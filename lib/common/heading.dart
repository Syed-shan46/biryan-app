import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/features/shop/screens/store/store_screen.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // title
          ReusableText(
            text: title,
            style: appStyle(
              17,
              ThemeUtils.dynamicTextColor(context).withOpacity(0.9),
              FontWeight.w600,
            ),
          ),
          // IconButton
          IconButton(
            onPressed: () {
              Get.to(() => const StoreScreen());
            },
            icon: SvgPicture.asset(
              'assets/icons/more-7.svg',
              height: 23,
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
