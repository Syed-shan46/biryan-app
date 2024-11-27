import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/utils/constants/uidata.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      padding: EdgeInsets.only(left: 12.w, top: 10.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categories.length, (i) {
          var category = categories[i];
          return Container(
            margin: EdgeInsets.only(right: 15.w),
            padding: EdgeInsets.only(top: 4.h),
            width: 54.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  child: Image.asset(
                    category['imageUrl'],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 4),
                ReusableText(
                  text: category['title'],
                  style: appStyle(11, ThemeUtils.dynamicTextColor(context),
                      FontWeight.normal),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
