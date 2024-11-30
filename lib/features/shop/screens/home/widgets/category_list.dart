import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/utils/constants/uidata.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 80.h, // Increased height for better alignment
      padding:
          EdgeInsets.only(left: 1.w, top: 10.h), // Added padding for spacing
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, i) {
          var category = categories[i];
          return Padding(
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
                      child: Image.asset(
                        category['imageUrl'],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 50.w, // Match the circle width
                  child: Text(
                    category['title'],
                    textAlign: TextAlign.center, // Center-align text
                    style: appStyle(11, ThemeUtils.dynamicTextColor(context),
                        FontWeight.normal),
                    maxLines: 1, // Handle longer titles gracefully
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
