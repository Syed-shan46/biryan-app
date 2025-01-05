import 'package:biriyani/features/shop/screens/home/product_detail/product_detail_screen.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/provider/curry_and_fry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurryAndFry extends ConsumerWidget {
  const CurryAndFry({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(
        curryAndFryProvider); // Watch the provider for the list of products
    final productNotifier = ref.read(curryAndFryProvider.notifier);

    // Load Curry and Fry products when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productNotifier.loadCurryAndFryProducts(); // Fetch products
    });

    // Show a loading spinner if products are still empty
    if (products.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Display products for both Curry and Fry
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
