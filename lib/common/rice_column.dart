import 'package:biriyani/features/shop/screens/home/product_detail/product_detail_screen.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_widget.dart';
import 'package:biriyani/provider/rice_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RiceWidget extends ConsumerWidget {
  const RiceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products =
        ref.watch(riceProvider); // Watch the provider for the list of products
    final productNotifier = ref.read(riceProvider.notifier);

    // Load Curry and Fry products when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productNotifier.loadCurryAndFryProducts(); // Fetch products
    });

    // Show a loading spinner if products are still empty
    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: const Skelton(
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    ),
                    const SizedBox(height: MySizes.spaceBtwItems),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: const Skelton(
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Skelton(),
                        ),
                        SizedBox(
                          width: MySizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Skelton(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
