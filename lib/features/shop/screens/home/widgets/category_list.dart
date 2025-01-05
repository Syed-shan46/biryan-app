import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/features/shop/controllers/category_controller.dart';
import 'package:biriyani/features/shop/screens/store/store_screen.dart';
import 'package:biriyani/provider/category_provider.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final categories = ref.watch(categoryProvider);
    return Container(
      height: 80.h, // Increased height for better alignment
      padding:
          EdgeInsets.only(left: 1.w, top: 10.h), // Added padding for spacing
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          var category = categories[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => StoreScreen(selectedCategoryIndex: index));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  right: 15.w), // Consistent spacing between items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 47.w, // Adjust circle size for better appearance
                    height: 47.w,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.blueGrey.withOpacity(0.1)
                          : Colors.white,
                      boxShadow: isDarkMode
                          ? []
                          : const [
                              BoxShadow(
                                color: Color.fromRGBO(99, 99, 99, 0.2),
                                offset: Offset(0, 2),
                                blurRadius: 1,
                                spreadRadius: 0,
                              ),
                            ],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 30.h,
                        child: Image.network(
                          category.image,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported, size: 30.h);
                          },
                        ),
                      ),
                    ),
                  ).animate(delay: 400.ms).shimmer(
                      duration: 1000.ms,
                      color: AppColors.primaryColor.withOpacity(0.2)),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 50.w, // Match the circle width
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center, // Center-align text
                      style: appStyle(11, ThemeUtils.dynamicTextColor(context),
                          FontWeight.normal),
                      maxLines: 1, // Handle longer titles gracefully
                      overflow: TextOverflow.ellipsis, // Prevent text overflow
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
