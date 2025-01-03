import 'package:biriyani/features/shop/controllers/productController.dart';
import 'package:biriyani/features/shop/screens/home/product_detail/product_detail_screen.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FoodList extends ConsumerStatefulWidget {
  const FoodList({super.key});

  @override
  ConsumerState<FoodList> createState() => _FoodListState();
}

class _FoodListState extends ConsumerState<FoodList> {
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
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 11.w),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        clipBehavior: Clip.none,
        itemBuilder: (context, i) {
          final product = products[i];

          return FoodWidget(
            product: product,
            onTap: () {
              print('Navigating to product detail screen');
              Get.to(() => ProductDetailScreen(product: product));
            },
          );
        },
      ),
    );
  }
}
