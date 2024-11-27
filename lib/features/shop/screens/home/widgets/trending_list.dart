import 'package:biriyani/utils/constants/uidata.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.h,
      padding: EdgeInsets.only(left: 12.w),
      child: ListView( 
        scrollDirection: Axis.horizontal,
        children: List.generate(foods.length, (i){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container( 
              height: 200.h,
              width: 150.w,
              color: AppColors.primaryColor,
            ),
          );
        }),
      ),
    );
  }
}
