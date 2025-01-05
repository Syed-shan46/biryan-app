// ignore_for_file: unused_import, unnecessary_import

import 'dart:async';
import 'dart:convert';
import 'package:biriyani/features/shop/controllers/additional_controller.dart';
import 'package:biriyani/features/shop/models/additional_model.dart';
import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/provider/additional_provider.dart';
import 'package:biriyani/provider/cart_provider.dart';
import 'package:biriyani/provider/wishlist_provider.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/appbar/custom_appbar.dart';
import 'package:biriyani/common/custom_shapes/curved_edges_widget.dart';
import 'package:biriyani/common/heading.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/authentication/models/product.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_list.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:biriyani/features/shop/screens/product_review/product_review.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/utils/animation/page_transition.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  // ignore: library_private_types_in_public_api
  State createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;
  bool _showBottomNav = false;

  @override
  void initState() {
    super.initState();
    print("Timer started for 7 seconds...");
    // Add a delay before showing the BottomNavigationBar
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _showBottomNav = true;
      });
      print("BottomNavigationBar is now visible");
    });
  }

  void _shareContent() {
    const String shareText = 'check out this amazing product';
    Share.share(
      shareText,
      subject: 'Product Details',
    );
  }

  @override
  Widget build(BuildContext context) {
    final playDuration = 600.ms;

    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: _showBottomNav
          ? BottomNavigationBtn(
              product: widget.product,
            ).animate().slideY(
                begin: 1, // Start below the screen
                end: 0, // End at normal position
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 800),
              )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailImages(
              images: widget.product.images,
              playDuration: playDuration,
              product: widget.product,
            ),
            NoTransitionAnimation(
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Row

                    const SizedBox(height: MySizes.spaceBtwItems),
                    // Product name and description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.product.itemName,
                                style: appStyle(
                                    24,
                                    ThemeUtils.dynamicTextColor(context),
                                    FontWeight.w600),
                              ),
                              IconButton(
                                onPressed: () {
                                  _shareContent();
                                },
                                icon: const Icon(Icons.share),
                                color: Colors.red,
                              )
                            ],
                          ),

                          // Description
                          Text(
                            widget.product.description,
                            style: appStyle(12, Colors.grey, FontWeight.normal),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(
                              duration: 300.ms,
                              delay: playDuration,
                              curve: Curves.decelerate)
                          .slideX(begin: 0.2, end: 0),
                    ),
                    const SizedBox(height: MySizes.spaceBtwSections),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ReusableText(
                        text: 'Recommended dishes',
                        style: appStyle(
                            17,
                            ThemeUtils.dynamicTextColor(context),
                            FontWeight.w500),
                      ),
                    ).animate().scaleXY(
                        begin: 0,
                        end: 1,
                        delay: 300.ms,
                        duration: playDuration - 100.ms,
                        curve: Curves.decelerate),

                    const FoodList().animate().scaleXY(
                        begin: 0,
                        end: 1,
                        delay: 300.ms,
                        duration: playDuration - 100.ms,
                        curve: Curves.decelerate)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  final Duration playDuration;
  const IconRow({
    super.key,
    required this.playDuration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://lottie.host/8dfd4a81-7e97-4d67-a2e3-c2b41c85a4fc/YO9p60Liua.json',
                width: 40.w, // Set width to a fraction of screen width
                height: 40.h, // Set height to a fraction of screen height
                fit: BoxFit
                    .contain, // Ensure the animation scales without distortion
              ),
              SizedBox(height: 3.h),
              const Text('20-25 min'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://lottie.host/01e5a673-32f6-4567-9699-7d876f4a3520/mIMXpWSAo5.json',
                width: 40.w, // Set width to a fraction of screen width
                height: 40.h, // Set height to a fraction of screen height
                fit: BoxFit
                    .contain, // Ensure the animation scales without distortion
              ),
              SizedBox(height: 3.h),
              const Text('10-15 min'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://lottie.host/956b8811-6f7c-433d-84f2-4106dc5da4df/X2loWr48kp.json',
                width: 40.w, // Set width to match the previous Lottie width
                height: 40.h, // Set height to match the previous Lottie height
                fit: BoxFit.contain, // Ensure the animation scales properly
              ),
              SizedBox(height: 3.h),
              const Text('4.9'),
            ],
          ),
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                'https://lottie.host/f1bae17f-9cb6-4dac-8571-db15b0f011f9/nCb5tKgyIc.json',
                width: 40.w, // Set width to match the previous Lottie width
                height: 40.h, // Set height to match the previous Lottie height
                fit: BoxFit.contain, // Ensure the animation scales properly
              ),
              SizedBox(height: 3.h),
              const Text('350g  '),
            ],
          ),
        ],
      ).animate().scaleXY(
          begin: 0,
          end: 1,
          delay: 300.ms,
          duration: playDuration - 100.ms,
          curve: Curves.decelerate),
    );
  }
}

class BottomNavigationBtn extends ConsumerStatefulWidget {
  const BottomNavigationBtn({super.key, required this.product});

  final Product product;

  @override
  ConsumerState<BottomNavigationBtn> createState() =>
      _BottomNavigationBtnState();
}

class _BottomNavigationBtnState extends ConsumerState<BottomNavigationBtn> {
  bool isAdded = false;
  late Future<List<Item>> futureItems;
  int currentQuantity = 1;
  List<Item> selectedItems = []; // To store selected additional items

  // Define the fetchItems function

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartPvr = ref.read(cartProvider.notifier);
    final cartState = ref.watch(cartProvider); // Watch for cart state changes

    // Watch for cart state changes
    // Ensure the cart state reflects properly when the cart is updated
    if (cartState.containsKey(widget.product.id)) {
      setState(() {
        currentQuantity = cartPvr.getQuantity(widget.product.id);
        isAdded = true;
      });
    } else {
      setState(() {
        isAdded = false;
      });
    }

    // Update quantity
    void increaseQuantity() {
      final newQuantity = currentQuantity + 1;
      ref
          .read(cartProvider.notifier)
          .updateQuantity(widget.product.id, newQuantity);
    }

    void decreaseQuantity() {
      if (currentQuantity > 1) {
        final newQuantity = currentQuantity - 1;
        ref
            .read(cartProvider.notifier)
            .updateQuantity(widget.product.id, newQuantity);
      }
    }

    // Collect selected items
    void updateSelectedItems(Item item, bool isSelected) {
      setState(() {
        if (isSelected) {
          selectedItems.add(item); // Add item to selected list
        } else {
          selectedItems.remove(item); // Remove item from selected list
        }
      });
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 12.h),
      decoration: BoxDecoration(
        color: ThemeUtils.sameBrightness(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),

      // Add to Cart and price
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                '₹${widget.product.itemPrice * currentQuantity}',
                style: appStyle(
                    18, ThemeUtils.dynamicTextColor(context), FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (currentQuantity > 1) {
                      setState(() {
                        currentQuantity -= 1;
                      });
                      cartPvr.updateQuantity(
                          widget.product.id, currentQuantity);
                    }
                  },
                  // Remove button -
                  child: const Icon(
                    Icons.remove_circle_outline_outlined,
                    size: 28,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '$currentQuantity',
                  style: appStyle(17, ThemeUtils.dynamicTextColor(context),
                      FontWeight.w400),
                ),
                SizedBox(width: 6.w),

                // ignore: prefer_const_constructors
                InkWell(
                  onTap: () {
                    setState(() {
                      currentQuantity += 1;
                    });
                    cartPvr.updateQuantity(widget.product.id, currentQuantity);
                  },
                  child: const Icon(Icons.add_circle_outline_outlined,
                      size: 28, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 145.w,
            height: 37.h,
            child: widget.product.isAvailable
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: () {
                      try {
                        cartPvr.addItemToCart(
                          itemName: widget.product.itemName,
                          itemPrice: widget.product.itemPrice,
                          category: widget.product.category,
                          image: widget.product.images,
                          quantity: currentQuantity,
                          itemId: widget.product.id,
                        );

                        Get.to(() => const CartScreen(
                              showBackArrow: true,
                            ));
                      } finally {}
                    },
                    child: const Text('Add to cart'),
                  )
                : SizedBox(
                    width: 145.w,
                    height: 37.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.9),
                          foregroundColor: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Not available')),
                  ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

// Checkout Button
class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'Checkout',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: ThemeUtils.sameBrightness(context)),
            )));
  }
}

class ProductDetailImages extends ConsumerStatefulWidget {
  final Duration playDuration;
  final List<String> images;
  const ProductDetailImages({
    super.key,
    required this.product,
    required this.images,
    required this.playDuration,
  });

  final Product? product;

  @override
  ConsumerState<ProductDetailImages> createState() =>
      _ProductDetailImagesState();
}

class _ProductDetailImagesState extends ConsumerState<ProductDetailImages> {
  bool isFavorited = false;
  @override
  void initState() {
    super.initState();
    // Check if the product is already in the cart and set isAdded accordingly

    final favState = ref.read(favoriteProvider);

    if (favState.containsKey(widget.product?.id)) {
      setState(() {
        isFavorited = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    final faveState = ref.watch(favoriteProvider);

    if (faveState.containsKey(widget.product?.id)) {
      setState(() {
        isFavorited = true;
      });
    } else {
      setState(() {
        isFavorited = false;
      });
    }

    return MyCurvedWidget(
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        child: Stack(
          children: [
            // Carousel Slider positioned at the base of the stack
            CarouselSlider(
              items: widget.images.map((imagePath) {
                return Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }).toList(),
              options: CarouselOptions(
                height: 325.h,
                enlargeCenterPage: true,
                autoPlay: true,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
              ),
            )
                .animate(delay: 400.ms)
                .shimmer(duration: widget.playDuration - 200.ms)
                .fade(),

            // Positioning the AppBar above the CarouselSlider
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MyAppBar(
                showBackArrow: true,
                actions: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                        if (isFavorited) {
                          favoriteProviderData.addProductToFavorite(
                            itemName: widget.product!.itemName,
                            itemPrice: widget.product!.itemPrice,
                            quantity: widget.product!.quantity,
                            category: widget.product!.category,
                            image: widget.product!.images,
                            productId: widget.product!.id,
                          );
                        } else {
                          favoriteProviderData
                              .removeFavItem(widget.product!.id);
                        }
                      },
                      child: Icon(
                        isFavorited ? Iconsax.heart5 : Iconsax.heart,
                        color: isFavorited
                            ? Colors.red
                            : ThemeUtils.dynamicTextColor(context),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Dot navigation at the bottom of the image
          ],
        ),
      ),
    );
  }
}
