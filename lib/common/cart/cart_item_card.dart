import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    required this.showQuantity,
    required this.showButtons,
    super.key,
  });

  final bool showButtons;
  final bool showQuantity;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Column(
        children: [
          SizedBox(height: MySizes.spaceBtwItems),
        ],
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          decoration: getDynamicBoxDecoration(context),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 55.h,
                    width: 65.w,
                    child: Image.asset(
                      
                      'assets/images/mb.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: MySizes.spaceBtwItems),

                // title, price, size
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Categories
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? AppColors.primaryColor
                                            .withOpacity(0.8)
                                        : AppColors.primaryColor
                                            .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                child: const Text('Rice'),
                              )
                            ],
                          ),

                          // Price
                          Row(
                            children: [
                              Text('₹120',
                                  style: appStyle(
                                      16,
                                      ThemeUtils.dynamicTextColor(context),
                                      FontWeight.w400)),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 2),

                      // Product name
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Biriyani',
                          style: TextStyle(
                              color: ThemeUtils.dynamicTextColor(context)
                                  .withOpacity(0.8)),
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showButtons
                              ? const Row(
                                  children: [
                                    InkWell(
                                        child: Text(
                                      'Remove',
                                      style: TextStyle(color: Colors.red),
                                    ))
                                  ],
                                )
                              : showQuantity
                                  ? const Text(
                                      'Quantity:',
                                    )
                                  : const Text('Processing'),
                          Row(
                            children: [
                              showButtons
                                  ? InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.remove_circle_outline,
                                        size: 19,
                                      ),
                                    )
                                  : const Text(''),
                              const SizedBox(
                                width: 5,
                              ),
                              showButtons ? const Text('2') : const Text('2'),
                              const SizedBox(
                                width: 5,
                              ),
                              showButtons
                                  ? InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.add_circle_outline_outlined,
                                        size: 19,
                                        color: Colors.blue.withOpacity(0.8),
                                      ),
                                    )
                                  : const Text(''),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
