import 'package:biriyani/common/cart/cart_icon.dart';
import 'package:biriyani/common/cart/cart_item_card.dart';
import 'package:biriyani/features/authentication/screens/login/login.dart';
import 'package:biriyani/features/authentication/screens/login/phone_verification_page.dart';
import 'package:biriyani/features/shop/controllers/get_customer_device_token.dart';
import 'package:biriyani/features/shop/controllers/order_controller.dart';
import 'package:biriyani/features/shop/models/cart_model.dart';
import 'package:biriyani/features/shop/screens/order/success_screen.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/provider/cart_provider.dart';
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
import 'package:phone_otp_verification/phone_verification.dart';

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
    final welcomeOffer = 50;
    final cartData = ref.watch(cartProvider);
    final totalAmount = getTotalAmount(cartData);
    final _cartProvider = ref.watch(cartProvider.notifier);
    final _cartNotifier = ref.read(cartProvider.notifier);
    final user = ref.watch(userProvider);
    final frUser = FirebaseAuth.instance.currentUser;

    final OrderController _orderController = OrderController();
    return Scaffold(
      /// Appbar
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBackArrow ? true : false,
        title: const Text('Cart').animate().slideY(
              begin: 10, // Start below the screen
              end: 0, // End at normal position
              curve: Curves.easeInOut,
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 500),
            ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: const MyCartIcon().animate().slideY(
                  begin: 10, // Start below the screen
                  end: 0, // End at normal position
                  curve: Curves.easeInOut,
                  // ignore: prefer_const_constructors
                  delay: Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 500),
                ),
          )
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
                      Future.forEach(_cartProvider.getCartItems.entries,
                          (entry) {
                        var item = entry.value;
                        _orderController.createOrders(
                          name: user.userName,
                          phone: user.phone,
                          address: user.userName,
                          id: user.id,
                          productName: item.itemName,
                          quantity: item.quantity,
                          category: item.category,
                          image: item.image[0],
                          totalAmount: totalAmount - welcomeOffer,
                          paymentStatus: 'Success',
                          orderStatus: 'Processing',
                          delivered: false,
                          customerDeviceToken: getCustomerDeviceToken(),
                          context: context,
                        );
                      });

                      Get.to(() => const SuccessScreen());

                      await Future.forEach(_cartProvider.getCartItems.entries,
                          (entry) {
                        var item = entry.value;
                        FirebaseFirestore.instance
                            .collection('notifications')
                            .doc(frUser!.uid)
                            .collection('notifications')
                            .doc()
                            .set({
                          'title': "Order Successfully Placed ${item.itemName}"
                        });
                      });

                      await Future.forEach(_cartProvider.getCartItems.entries,
                          (entry) {
                        var item = entry.value;
                        SendNotificationService.sendNotificationUsingApi(
                            token:
                                'eCa1TFIRRjOFp86ZIlk2z-:APA91bE_9RwIWkKi0a59f3LH1vsL-fOPqf9enq0eNZItRMbzn3y8tgODqFzlsPgDLQSi4IFEAI5nBkfNh67weJM8mAEJJ2zVsWda-pVzHbMaQHdcFhjluDs',
                            title: 'New Order ${item.itemName}',
                            body: 'Price ${item.itemPrice}');
                      });
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
                ).animate().slideY(
                      begin: 10, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 500),
                    ),
              ),
            ),

      // Heading and cart items
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                    'https://lottie.host/e5c80fca-fe94-4bed-9424-e0d70204d1aa/lhGyjYqBYY.json',
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
                    padding: EdgeInsets.all(MySizes.spaceBtwItems),
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

                  Divider(
                          color: Colors.grey.withOpacity(0.3),
                          indent: 20,
                          endIndent: 20)
                      .animate()
                      .slideX(
                        begin: -5, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 1000),
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
                              delay: const Duration(milliseconds: 1000),
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
                                      color: AppColors.primaryColor.withOpacity(0.9)),
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
                              delay: const Duration(milliseconds: 1000),
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
                          delay: Duration(milliseconds: 200),
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
                              color: AppColors.accentColor),
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
