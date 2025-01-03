// ignore_for_file: unused_field

import 'dart:math';

import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/custom_container.dart';
import 'package:biriyani/common/custom_text_field.dart';
import 'package:biriyani/features/shop/screens/home/product_detail/product_detail_screen.dart';
import 'package:biriyani/features/shop/screens/search/widgets/loading_widget.dart';
import 'package:biriyani/features/shop/search_controller.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class SearchScreen extends ConsumerWidget {
  SearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 74.h,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: CustomTextWidget(
              onChanged: (query) {
                // Update the search query when text changes
                ref.read(searchQueryProvider.notifier).state = query;
              },
              controller: _searchController,
              keyboardType: TextInputType.text,
              hintText: "Search For Foods",
              suffixIcon: _searchController.text.isEmpty
                  ? Icon(Icons.search, color: Colors.grey)
                  : GestureDetector(
                      onTap: () {
                        // Clear the text field when clear icon is tapped
                        _searchController.clear();
                        ref.read(searchQueryProvider.notifier).state =
                            ''; // Clear search query
                      },
                      child: Icon(Icons.clear, color: Colors.grey),
                    ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              if (searchQuery.isEmpty)
                const Text("")
              else
                // Handle the state of the search results using .when
                searchResults.when(
                  data: (products) {
                    if (products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ProductDetailScreen(product: product));
                            },
                            child: Container(
                              height: 60.h,
                              padding: EdgeInsets.all(5.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.hardEdge,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              product.images[0],
                                              width: 60.w,
                                              height: 50.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom:
                                                0, // Position stars at the bottom of the image
                                            left: 0,
                                            right: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(8),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  8))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children:
                                                    List.generate(4, (index) {
                                                  return const Icon(
                                                    Icons.star,
                                                    size: 13, // Size of the star
                                                    color: Colors
                                                        .amber, // Star color
                                                  );
                                                }),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.itemName,
                                            style: appStyle(
                                              14,
                                              ThemeUtils.dynamicTextColor(context)
                                                  .withOpacity(0.8),
                                              FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Delivery in 30 mins',
                                            style: appStyle(
                                                11,
                                                ThemeUtils.dynamicTextColor(
                                                        context)
                                                    .withOpacity(0.8),
                                                FontWeight.normal),
                                          ),
                                          const SizedBox(height: 2),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.accentColor
                                                  .withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              product.category,
                                              style: appStyle(
                                                11.sp,
                                                Colors.white,
                                                FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primaryColor.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text('₹${product.itemPrice}',
                                        style: appStyle(
                                          11.sp,
                                          Colors.white.withOpacity(0.9),
                                          FontWeight.w600,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => Center(child: Text('')),
                  error: (error, stackTrace) => Center(
                    child: Text(''),
                  ),
                ),
              const LoadingWidget(),
            ],
          ),
        ));
  }
}
