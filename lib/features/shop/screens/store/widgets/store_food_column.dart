import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/provider/category_by_product_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductColumn extends ConsumerWidget {
  final String categoryId;

  const ProductColumn({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(categoryByproductProvider);
    final productNotifier = ref.read(categoryByproductProvider.notifier);

    // Only load the products if they are not already cached
    if (!products.containsKey(categoryId)) {
      productNotifier.loadProductsByCategory(categoryId);
    }

    // Check if products are still empty (e.g., loading state)
    if (!products.containsKey(categoryId)) {
      return Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: AppColors.primaryColor,
          size: 25,
        ),
      );
    }

    final productList = products[categoryId]!;

    return Padding(
      padding: const EdgeInsets.only(left: MySizes.spaceBtwItems),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 7, mainAxisSpacing: 18),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            final product = productList[index];

            return FoodWidget(
              product: product,
            );
          }),
    );
  }
}
