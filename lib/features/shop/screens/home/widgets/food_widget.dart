import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/authentication/models/product.dart';
import 'package:biriyani/features/shop/screens/home/product_detail/product_detail_screen.dart';
import 'package:biriyani/provider/wishlist_provider.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FoodWidget extends ConsumerStatefulWidget {
  const FoodWidget({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
  final void Function()? onTap;

  @override
  ConsumerState<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends ConsumerState<FoodWidget> {
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    // Check if the product is already in the cart and set isAdded accordingly

    final favState = ref.read(favoriteProvider);

    if (favState.containsKey(widget.product.id)) {
      setState(() {
        isFavorited = true;
      });
    }
  }

  bool? isAvailable;

  @override
  Widget build(BuildContext context) {
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    final favState = ref.watch(favoriteProvider);

    if (favState.containsKey(widget.product.id)) {
      setState(() {
        isFavorited = true;
      });
    } else {
      setState(() {
        isFavorited = false;
      });
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: widget.product),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 12.w,),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: width * .41,
            decoration: getDynamicBoxDecoration(context),
            child: Column(
              // Use Column instead of ListView
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                // Image Section
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.w),
                        topRight: Radius.circular(12.w),
                      ),
                      child: SizedBox(
                        height: 100.h,
                        width: width * 0.8,
                        child: Image.network(
                          widget.product.images[0],
                          fit: BoxFit.cover,
                        ).animate(delay: 400.ms).shimmer(
                              duration: 1000.ms,
                            ),
                      ),
                    ),
                    Positioned(
                      left: 5.w,
                      top: 4.h,
                      child: Container(
                        width: 37.w,
                        height: 37.w,
                        decoration: BoxDecoration(
                          color: ThemeUtils.sameBrightness(context)
                              .withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: IconButton(
                            key: ValueKey<bool>(isFavorited),
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                isFavorited = !isFavorited;
                              });
                              if (isFavorited) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 80.w, vertical: 13.h),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.heart_add,
                                          color: ThemeUtils.sameBrightness(
                                              context),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          'Added to Wishlist',
                                          style: TextStyle(
                                              color: ThemeUtils.sameBrightness(
                                                  context)), // Text color
                                        ),
                                      ],
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: ThemeUtils.dynamicTextColor(
                                        context), // SnackBar background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          50), // Border radius
                                    ),
                                    // Margin from the edges and bottom
                                    duration: const Duration(
                                        seconds:
                                            2), // Duration before hiding the snackbar
                                  ),
                                );
                                favoriteProviderData.addProductToFavorite(
                                  itemName: widget.product.itemName,
                                  itemPrice: widget.product.itemPrice,
                                  quantity: widget.product.quantity,
                                  category: widget.product.category,
                                  image: widget.product.images,
                                  productId: widget.product.id,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 70.w, vertical: 13.h),
                                    content: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.heart_remove,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Removed From Wishlist',
                                          style: TextStyle(
                                              color:
                                                  Colors.white), // Text color
                                        ),
                                      ],
                                    ),

                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: AppColors
                                        .accentColor, // SnackBar background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          50), // Border radius
                                    ),

                                    // Margin from the edges and bottom
                                    duration: const Duration(
                                        seconds:
                                            2), // Duration before hiding the snackbar
                                  ),
                                );
                                favoriteProviderData
                                    .removeFavItem(widget.product.id);
                              }
                            },
                            icon: Icon(
                              isFavorited ? Iconsax.heart5 : Iconsax.heart,
                              color: isFavorited
                                  ? Colors.red
                                  : ThemeUtils.dynamicTextColor(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      left: 10.w,
                      child: widget.product.isAvailable
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(4),
                              decoration:
                                  const BoxDecoration(color: Colors.red),
                              child: const Text(
                                'Currently Not Available',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    )
                  ],
                ),
                // Details Section
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: widget.product.itemName,
                            style: appStyle(
                                12,
                                ThemeUtils.dynamicTextColor(context),
                                FontWeight.w500),
                          ),
                          ReusableText(
                            text: widget.product.itemPrice.toString(),
                            style: appStyle(
                                12, AppColors.primaryColor, FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Delivery time',
                            style: appStyle(9, Colors.grey, FontWeight.w500),
                          ),
                          ReusableText(
                            text: '20min',
                            style: appStyle(9, Colors.grey, FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
