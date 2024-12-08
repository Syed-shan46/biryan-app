import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/authentication/models/product.dart';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.price,
    required this.product,
    this.onTap,
  });

  final String image;
  final String title;
  final String time;
  final String price;
   final Product product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('product_details');
      },
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
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
                      child: Image.asset(
                        image,
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
                        color:
                            ThemeUtils.sameBrightness(context).withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            // Add functionality for the button
                          },
                          icon: Icon(
                            Iconsax.heart,
                            size: 22,
                            color: ThemeUtils.dynamicTextColor(context),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                          text: product.itemName,
                          style: appStyle(
                              12,
                              ThemeUtils.dynamicTextColor(context),
                              FontWeight.w500),
                        ),
                        ReusableText(
                          text: product.itemPrice.toString(),
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
                          text: time,
                          style: appStyle(9, Colors.grey, FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
