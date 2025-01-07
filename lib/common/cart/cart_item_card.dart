import 'package:biriyani/features/shop/controllers/productController.dart';
import 'package:biriyani/features/shop/models/cart_model.dart';
import 'package:biriyani/provider/cart_provider.dart';
import 'package:biriyani/provider/product_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/helpers/box_decoration_helper.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemCard extends ConsumerStatefulWidget {
  const CartItemCard({
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
  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadProducts();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print('Error $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(cartProvider.notifier);
    ref.watch(cartProvider); // Watch for cart state changes

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
                                  print('triggered');
                                  
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(2))),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 1),
                                  child: Text(
                                    cartItem.category,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
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
