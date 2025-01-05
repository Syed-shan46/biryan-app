import 'package:biriyani/common/cart/cart_icon.dart';
import 'package:biriyani/common/cart/cart_item_card.dart';
import 'package:biriyani/features/authentication/screens/login/phone_verification_page.dart';
import 'package:biriyani/features/shop/controllers/get_customer_device_token.dart';
import 'package:biriyani/features/shop/controllers/order_controller.dart';
import 'package:biriyani/features/shop/models/cart_model.dart';
import 'package:biriyani/features/shop/screens/order/success_screen.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/provider/cart_provider.dart';
import 'package:biriyani/provider/product_provider.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/services/get_service_key.dart';
import 'package:biriyani/services/notification_service.dart';
import 'package:biriyani/services/send_notification_service.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:bounce/bounce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key, this.showBackArrow = false});

  final bool showBackArrow;

  @override
  // ignore: library_private_types_in_public_api
  ConsumerState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen>
    with SingleTickerProviderStateMixin {
  NotificationService notificationService = NotificationService();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //Checking if already address is on Db
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    final cartState = ref.read(cartProvider);
  }

  double getEachTotal(Map<String, Cart> cartData) {
    double eachTotal = 0.0;
    cartData.forEach((key, cartItem) {
      eachTotal += cartItem.totalPrice; // Use the totalPrice method
    });
    return eachTotal;
  }

  int getTotalAmount(Map<String, Cart> cartData) {
    int total = 0;
    cartData.forEach((key, cartItem) {
      total += cartItem.itemPrice * cartItem.quantity; // Calculate total
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    bool isAdded = false;
    final welcomeOffer = 50;
    final cartData = ref.watch(cartProvider);
    final totalAmount = getTotalAmount(cartData);
    final _cartProvider = ref.watch(cartProvider.notifier);
    final user = ref.watch(userProvider);
    final frUser = FirebaseAuth.instance.currentUser;
    final cartProvide = ref.read(cartProvider.notifier);
    final cartState = ref.watch(cartProvider); // Watch for cart state changes

    final OrderController _orderController = OrderController();
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        title: const Text('Cart'),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 15), child: MyCartIcon())
        ],
      ),

      // Checkout button
      bottomNavigationBar: cartData.isEmpty
          ? const PurchaseBtn()
          : Padding(
              padding: const EdgeInsets.all(MySizes.defaultSpace),
              child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (user == null) {
                        showVerificationSheet(context);
                      } else {
                        try {
                          // Aggregate cart item details into lists
                          List<String> productNames = [];
                          List<int> quantities = [];
                          List<String> categories = [];
                          List<String> images = [];
                          List<int> itemPrices = [];

                          _cartProvider.getCartItems.entries.forEach((entry) {
                            var item = entry.value;
                            productNames.add(item.itemName);
                            quantities.add(item.quantity);
                            categories.add(item.category);
                            itemPrices.add(item.itemPrice);
                            images.add(item.image.isNotEmpty
                                ? item.image[0]
                                : 'defaultImage');
                          });

                          // Create a single order
                          await _orderController.createOrders(
                            name: user.userName,
                            phone: user.phone,
                            address: user.userName,
                            id: user.id,
                            productName: productNames,
                            quantity: quantities,
                            itemPrice: itemPrices,
                            category: categories,
                            image: images,
                            totalAmount: totalAmount - welcomeOffer,
                            paymentStatus: 'Success',
                            orderStatus: 'Processing',
                            delivered: false,
                            customerDeviceToken: getCustomerDeviceToken(),
                            context: context,
                          );

                          // Save notification for the order
                          await FirebaseFirestore.instance
                              .collection('notifications')
                              .doc(frUser!.uid)
                              .collection('notifications')
                              .add({
                            'title': "Order Successfully Placed",
                            'products': productNames,
                          });

                          // Send notification to admin
                          SendNotificationService.sendNotificationUsingApi(
                            token: 'your-notification-token',
                            title: 'New Order',
                            body: 'New Order Received',
                          );
                        } catch (error) {
                          print("Error processing order: $error");
                        }

                        await Future.forEach(_cartProvider.getCartItems.entries,
                            (entry) {
                          var item = entry.value;
                          FirebaseFirestore.instance
                              .collection('notifications')
                              .doc(frUser!.uid)
                              .collection('notifications')
                              .doc()
                              .set({
                            'title':
                                "Order Successfully Placed ${item.itemName}"
                          });
                        });

                        SendNotificationService.sendNotificationUsingApi(
                            token:
                                'cJtGWwkfAlraxO4V0mzpca:APA91bHh0eBYk3dzk0hbo5zFoG2m9cuyVkoNeIDSXY6UHyp1dD1BfBtU9R2EdaBDliHaxIWuQlnqsNd1cb6-mA1rbD7HMcmq0wtiC3Yu5AnA2wA7zWNwcb0',
                            title: 'New Order ',
                            body: 'New Order Recieved');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                    child: Text(
                      'Place Order ₹${totalAmount - welcomeOffer}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ThemeUtils.sameBrightness(context)),
                    ),
                  )),
            ),

      // Heading and cart items
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    repeat: false,
                    'https://lottie.host/ed1474e2-1435-47b2-81f5-b0074cb72b13/XdQQTi3uQE.json',
                    width: 350,
                    height: 350,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 20),
                  const Text('Shopping Cart is Empty'),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Text
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 10),
                    child: Text('check and pay items'),
                  ).animate().slideY(
                        begin: 1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 500),
                      ),

                  // Cart items card
                  Padding(
                    padding: const EdgeInsets.all(MySizes.spaceBtwItems),
                    child: CartItemCard(
                      showQuantity: false,
                      showButtons: true,
                      cartData: cartData,
                      cartProvider: _cartProvider,
                    ),
                  ).animate().slideY(
                        begin: 0.3, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 500),
                      ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                
                                context: context,
                                builder: (BuildContext context) {
                                  final products = ref.watch(productProvider);
                                  final cartItems = ref.watch(
                                      cartProvider); // Watching cart provider

                                  if (products.isEmpty) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300.h,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10.h),
                                          const Text(
                                            'Available Products',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: products.length,
                                              itemBuilder: (context, index) {
                                                final product = products[index];

                                                // Check if the product is in the cart
                                                final isInCart =
                                                    cartItems.values.any(
                                                  (item) =>
                                                      item.itemId == product.id,
                                                );

                                                return ListTile(
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      if (isInCart) {
                                                        // Remove item from cart if already present
                                                        cartProvide
                                                            .removeCartItem(
                                                                product.id);
                                                      } else {
                                                        // Add item to cart if not present
                                                        cartProvide
                                                            .addItemToCart(
                                                          itemName:
                                                              product.itemName,
                                                          itemPrice:
                                                              product.itemPrice,
                                                          quantity:
                                                              product.quantity,
                                                          category:
                                                              product.category,
                                                          image: product.images,
                                                          itemId: product.id,
                                                        );
                                                      }
                                                    },
                                                    icon: AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds:
                                                              500), // Animation for color change
                                                      decoration: BoxDecoration(
                                                        color: isInCart
                                                            ? AppColors
                                                                .primaryColor // Color when the item is in the cart
                                                            : const Color(
                                                                0xFF2F3645), // Default color
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: SizedBox(
                                                        width: 30.w,
                                                        height: 30.h,
                                                        child: Center(
                                                          child:
                                                              AnimatedSwitcher(
                                                            duration: const Duration(
                                                                milliseconds:
                                                                    500), // Icon transition duration
                                                            transitionBuilder:
                                                                (child,
                                                                    animation) {
                                                              // Smooth icon transition using fade and scale
                                                              return FadeTransition(
                                                                opacity:
                                                                    animation,
                                                                child:
                                                                    ScaleTransition(
                                                                  scale:
                                                                      animation,
                                                                  child: child,
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                              isInCart
                                                                  ? Icons.check
                                                                  : Icons
                                                                      .add, // Icon changes based on cart state
                                                              key: ValueKey<
                                                                      bool>(
                                                                  isInCart), // Ensures a new widget instance for animation
                                                              color: isInCart
                                                                  ? ThemeUtils
                                                                      .sameBrightness(
                                                                          context) // Icon color when in cart
                                                                  : ThemeUtils
                                                                      .sameBrightness(
                                                                          context), // Default icon color
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  leading: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      product.images[0],
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    product.itemName,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: ThemeUtils
                                                          .dynamicTextColor(
                                                              context),
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    '₹${product.itemPrice}',
                                                    style: TextStyle(
                                                      color: ThemeUtils
                                                          .dynamicTextColor(
                                                              context),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    print(
                                                        'Selected: ${product.itemName}');
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Add items',
                                    style: TextStyle(
                                      color:
                                          ThemeUtils.dynamicTextColor(context)
                                              .withOpacity(0.8),
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    size: 14.sp,
                                    color: ThemeUtils.dynamicTextColor(context)
                                        .withOpacity(0.8),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).animate().slideY(
                            begin: 0.8, // Start below the screen
                            end: 0, // End at normal position
                            curve: Curves.easeInOut,
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 500),
                          ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Divider(
                          color: Colors.grey.withOpacity(0.3),
                          indent: 20,
                          endIndent: 20)
                      .animate()
                      .slideX(
                        begin: -5, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 700),
                        duration: const Duration(milliseconds: 500),
                      ),
                  const SizedBox(height: MySizes.spaceBtwItems),

                  // Coupon box

                  const SizedBox(height: MySizes.spaceBtwItems),

                  /// Price details
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MySizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('*FREE Delivery available With in 5Kms'),
                        const SizedBox(height: MySizes.spaceBtwItems),
                        Text(
                          'Price',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                        ).animate().slideX(
                              begin: -5, // Start below the screen
                              end: 0, // End at normal position
                              curve: Curves.easeInOut,
                              delay: const Duration(milliseconds: 700),
                              duration: const Duration(milliseconds: 500),
                            ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${cartData.length} items'),
                            Text(
                              '₹$totalAmount',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Welcome Offer'),
                            Text(
                              '- ₹50.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.9)),
                            )
                          ],
                        ),

                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Delivery Fee'),
                            Text(
                              '+ 00.00',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.withOpacity(0.9)),
                            )
                          ],
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems / 2),

                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                        ).animate().slideX(
                              begin: -5, // Start below the screen
                              end: 0, // End at normal position
                              curve: Curves.easeInOut,
                              delay: const Duration(milliseconds: 700),
                              duration: const Duration(milliseconds: 500),
                            ),

                        // Total Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹${totalAmount - welcomeOffer}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ],
                    ).animate().slideY(
                          begin: 0.3, // Start below the screen
                          end: 0, // End at normal position
                          curve: Curves.easeInOut,
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 500),
                        ),
                  )
                ],
              )
                  .animate(
                    autoPlay: false,
                    controller: _controller,
                  )
                  .blurXY(
                      begin: 0,
                      end: 25,
                      duration: 600.ms,
                      curve: Curves.easeInOut)
                  .scaleXY(begin: 1, end: 0.6)
                  .fadeOut(
                    begin: 1,
                  ),
            ),
    );
  }

  Future<dynamic> showVerificationSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 230.h,
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //   colorFilter: ColorFilter.mode(ThemeUtils.sameBrightness(context), BlendMode.dstATop),
              //   image: AssetImage('assets/images/products/bg-3.png'),
              //   fit: BoxFit.contain,
              // ),
              ),
          child: Padding(
            padding: EdgeInsets.all(9.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                const Text(
                  'Verify Your Phone Number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  child: Column(
                    children: (List.generate(
                      verificationReasons.length,
                      (index) {
                        return ListTile(
                          leading: const Icon(Icons.check_circle_outline,
                              color: AppColors.primaryColor),
                          title: Text(
                            verificationReasons[index],
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: ThemeUtils.dynamicTextColor(context)),
                          ),
                        );
                      },
                    )),
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),
                ElevatedButton(
                    onPressed: () {
                      Get.to(() => const PhoneVerificationPage());
                    },
                    child: Text('Verify Account',
                        style: TextStyle(
                          color: ThemeUtils.sameBrightness(context),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}

class PurchaseBtn extends StatelessWidget {
  const PurchaseBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: Bounce(
        tiltAngle: BorderSide.strokeAlignInside,
        filterQuality: FilterQuality.high,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const NavigationMenu());
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
            child: Text(
              'Buy Now',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ThemeUtils.sameBrightness(context)),
            ),
          ),
        ),
      ),
    );
  }
}

class CouponBox extends StatelessWidget {
  const CouponBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
      child: SizedBox(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Your Coupon Code',
                  filled: true,
                  fillColor: AppColors.primaryColor.withOpacity(0.1),
                  prefixIcon: Icon(
                    Icons.discount_outlined,
                    color: AppColors.primaryColor.withOpacity(0.5),
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            )
          ],
        ),
      ),
    );
  }
}
