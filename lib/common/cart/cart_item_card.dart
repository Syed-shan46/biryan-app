import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    required this.showQuantity,
    required this.showButtons,
    super.key,
  });

  final bool showButtons;
  final bool showQuantity;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool _isExpanded = false; // Track if the card is expanded

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
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          decoration: getDynamicBoxDecoration(context),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // image

                const SizedBox(width: MySizes.spaceBtwItems),

                // title, price, size
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Categories
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Biriyani'),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  print('trigered');
                                  showVerificationSheet(context);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Chicken Fry',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ThemeUtils.dynamicTextColor(
                                                  context)
                                              .withOpacity(0.8)),
                                    ),
                                    const Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5))),
                            child: Row(
                              children: [
                                widget.showButtons
                                    ? InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                            color: AppColors.accentColor,
                                            width: 15,
                                            'assets/icons/icons-minus.png'))
                                    : const Text(''),
                                const SizedBox(width: 12),
                                widget.showButtons
                                    ? Text(
                                        '2',
                                        style: textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const Text('2'),
                                const SizedBox(width: 12),
                                widget.showButtons
                                    ? InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                            color: AppColors.accentColor,
                                            width: 13,
                                            'assets/icons/icons-add.png'))
                                    : const Text(''),
                              ],
                            ),
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

                      // Product name
                      const SizedBox(height: MySizes.spaceBtwItems / 2),

                      // Cooking requests
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5))),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isExpanded =
                                          !_isExpanded; // Toggle the expanded state
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        _isExpanded
                                            ? Icons.expand_less
                                            : Icons.expand_more,
                                        size: 14,
                                        color: AppColors.accentColor,
                                      ),
                                      Text(
                                        'Requests',
                                        style: TextStyle(
                                            color: AppColors.accentColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: MySizes.spaceBtwItems),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.5))),
                                child: const Row(
                                  children: [
                                    InkWell(
                                        child: Row(
                                      children: [
                                        Icon(
                                          (Icons.add),
                                          size: 14,
                                          color: AppColors.accentColor,
                                        ),
                                        Text(
                                          ' Add Item',
                                          style: TextStyle(
                                              color: AppColors.accentColor),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),

                      // Expanded content that will show when _isExpanded is true
                      if (_isExpanded) ...[
                        const SizedBox(height: MySizes.spaceBtwItems),
                        TextFormField(
                          cursorColor: Colors.black,
                          autofocus: true,
                          showCursor: true,
                          decoration: InputDecoration(
                            hintText: 'Type Requests',
                            border:
                                InputBorder.none, // Removes the bottom border
                          ),
                        ),

                        // You can add more widgets here for expanded content
                      ],

                      // Save Button
                      if (_isExpanded)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement your save logic here
                              print("Saved successfully!");
                            },
                            child: const Text('Save'),
                          ),
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

  Future<dynamic> showVerificationSheet(BuildContext context) {
    bool _rememberMe = false; // Initial state
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsets.all(9.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Chicken Biriyani',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '₹199',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration:
                                            getDynamicBoxDecoration(context),
                                        child: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Text(
                                    'Customize as per your taste',
                                    style: appStyle(
                                      19,
                                      ThemeUtils.dynamicTextColor(context),
                                      FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Divider(
                              thickness: 0.3,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: MySizes.spaceBtwItems),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: getDynamicBoxDecoration(context),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/add-to-cart.png',
                                            width: 20.w,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            'Chicken Fry',
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            size: 13,
                                          ),
                                          const Text('110'),
                                          Transform.scale(
                                            scale: 0.8,
                                            child: Checkbox(
                                              value: _rememberMe,
                                              side: BorderSide(
                                                color:
                                                    ThemeUtils.dynamicTextColor(
                                                        context),
                                              ),
                                              onChanged: (value) {
                                                setModalState(() {
                                                  _rememberMe = value!;
                                                });
                                              },
                                              activeColor:
                                                  AppColors.primaryColor,
                                              checkColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/add-to-cart.png',
                                            width: 20.w,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('Chicken Fry')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            size: 13,
                                          ),
                                          const Text(' 110'),
                                          Transform.scale(
                                            scale: 0.8,
                                            child: Checkbox(
                                              value: _rememberMe,
                                              side: BorderSide(
                                                color:
                                                    ThemeUtils.dynamicTextColor(
                                                        context),
                                              ),
                                              onChanged: (value) {
                                                setModalState(() {
                                                  _rememberMe = value!;
                                                });
                                              },
                                              activeColor:
                                                  AppColors.primaryColor,
                                              checkColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: MySizes.spaceBtwItems),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  color: ThemeUtils.sameBrightness(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Bottom Navigation Bar
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: const Border(
                        top: BorderSide(color: Colors.grey, width: 0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Price
                      const Text(
                        'Total: ₹199',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Right: Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Example action
                        },
                        child: const Text('Update Item'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
