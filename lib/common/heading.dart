import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/common/reusable_text.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.spaceBtwItems),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // title
          ReusableText(
            text: title,
            style: appStyle(
              16,
              ThemeUtils.dynamicTextColor(context),
              FontWeight.w600,
            ),
          ),
          // Iconbutton
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/more-7.svg',
              height: 23,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
