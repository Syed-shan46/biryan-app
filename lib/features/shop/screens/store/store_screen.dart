import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/cart/cart_icon.dart';
import 'package:biriyani/common/custom_shapes/primary_header_container.dart';
import 'package:biriyani/features/shop/controllers/category_controller.dart';
import 'package:biriyani/features/shop/screens/search/search_screen.dart';
import 'package:biriyani/features/shop/screens/store/widgets/store_food_column.dart';
import 'package:biriyani/provider/category_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StoreScreen extends ConsumerStatefulWidget {
  final int? selectedCategoryIndex;
  const StoreScreen({
    super.key,
    this.selectedCategoryIndex = 1,
  });

  @override
  ConsumerState<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen> {
  // Fetching Categories

  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return DefaultTabController(
      initialIndex: widget.selectedCategoryIndex!,
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DynamicBg.sameBrightness(context),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: MyCartIcon(),
            )
          ],
        ),
        body: categories.isEmpty
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: AppColors.primaryColor, size: 25),
              )
            : NestedScrollView(
                headerSliverBuilder: (_, innerBoxScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: DynamicBg.sameBrightness(context),
                      pinned: true,
                      floating: true,
                      automaticallyImplyLeading: false,
                      expandedHeight: 120,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => SearchScreen());
                                },
                                child: TextFormField(
                                  onTap: () {
                                    Get.to(() => SearchScreen());
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.r),
                                      borderSide: BorderSide(
                                        color: ThemeUtils.dynamicTextColor(
                                            context), // Replace with desired color
                                        width: 1.w, // Adjust thickness
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.r),
                                      borderSide: BorderSide(
                                        color: ThemeUtils.dynamicTextColor(
                                            context), // Replace with desired color
                                        width: 1.w, // Adjust thickness
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.r),
                                      borderSide: BorderSide(
                                        color: AppColors
                                            .primaryColor, // Replace with desired color
                                        width: 1.5
                                            .w, // Adjust thickness for focused state
                                      ),
                                    ),
                                    hintText: 'Search for foods',
                                    hintStyle: appStyle(
                                        11,
                                        ThemeUtils.dynamicTextColor(context),
                                        FontWeight.normal),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        indicatorColor: AppColors.primaryColor,
                        unselectedLabelColor: Colors.grey,
                        tabAlignment: TabAlignment.start,
                        labelColor: AppColors.primaryColor,
                        dividerHeight: 0,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: categories
                            .map((category) => Tab(child: Text(category.name)))
                            .toList(),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  children: categories
                      .map((category) => Column(
                            children: [
                              const SizedBox(height: MySizes.spaceBtwItems),
                              ProductColumn(categoryId: category.name),
                            ],
                          ))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
