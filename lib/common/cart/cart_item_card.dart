import 'package:biriyani/features/shop/models/additional_model.dart';
import 'package:biriyani/features/shop/models/cart_model.dart';
import 'package:biriyani/provider/additional_provider.dart';
import 'package:biriyani/provider/cart_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartItemCard extends ConsumerStatefulWidget {
  CartItemCard({
    required this.showQuantity,
    required this.showButtons,
    required CartNotifier cartProvider,
    required this.cartData,
    super.key,
  }) : _cartProvider = cartProvider;

  final Map<String, Cart> cartData;
  final CartNotifier _cartProvider;
  final bool showButtons;
  final bool showQuantity;

  @override
  ConsumerState<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends ConsumerState<CartItemCard> {
  bool _isExpanded = false;
  bool _rememberMe = false; // Initial state
  List<Item> selectedItems = [];

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

  void showFullCartData() {
    final fullCart = widget.cartData.values.toList(); // Access the cart values
    final fullCartDetails = fullCart.map((cartItem) {
      return {
        'itemName': cartItem.itemName,
        'itemPrice': cartItem.itemPrice,
        'quantity': cartItem.quantity,
        'additionalItems': cartItem.additionalItems
            .map((item) => {
                  'addItemName': item.addItemName,
                  'addItemPrice': item.addItemPrice,
                })
            .toList(),
      };
    }).toList();

    Get.snackbar('Additional', '$fullCartDetails');
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(selectedItemsProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final selectedItems = ref.watch(selectedItemsProvider);
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Column(
        children: [
          SizedBox(height: MySizes.spaceBtwItems),
        ],
      ),
      itemCount: widget.cartData.length,
      itemBuilder: (context, index) {
        final cartItem = widget.cartData.values.toList()[index];
        return Container(
          decoration: getDynamicBoxDecoration(context),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // image (you can add the image here if needed)

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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(cartItem.itemName), // Cart Item Name
                                ],
                              ),

                              // Customize Button
                              InkWell(
                                onTap: () {
                                  Get.snackbar(' Not Available',
                                      "Currently not available to request 😊",
                                      backgroundColor: AppColors.lightBackground
                                          .withOpacity(0.6),
                                      icon: const Icon(Icons.message_outlined));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Request',
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

                          // Price Section
                          Text('₹${cartItem.totalPrice}'),

                          // Cart Quantity Buttons
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
                                        onTap: () {
                                          widget._cartProvider
                                              .decrementCartItem(
                                                  cartItem.itemId);
                                        },
                                        child: Image.asset(
                                            color: AppColors.primaryColor,
                                            width: 15,
                                            'assets/icons/icons-minus.png'))
                                    : const Text(''),
                                const SizedBox(width: 12),
                                widget.showButtons
                                    ? Text(
                                        cartItem.quantity.toString(),
                                        style: textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const Text('2'),
                                const SizedBox(width: 12),
                                widget.showButtons
                                    ? InkWell(
                                        onTap: () {
                                          widget._cartProvider
                                              .incrementCartItem(
                                                  cartItem.itemId);
                                        },
                                        child: Image.asset(
                                            color: AppColors.primaryColor,
                                            width: 13,
                                            'assets/icons/icons-add.png'))
                                    : const Text(''),
                              ],
                            ),
                          ),
                        ],
                      ),
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
