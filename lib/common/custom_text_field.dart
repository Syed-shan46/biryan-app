import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {super.key,
      this.keyboardType,
      this.onChanged,
      this.controller,
      this.onEditingComplete,
      this.obscureText,
      this.suffixIcon,
      this.validator,
      this.onTap,
      this.prefixIcon,
      this.hintText});

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.r),
      ),
      child: TextFormField(
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
        keyboardType: keyboardType,
        onEditingComplete: onEditingComplete,
        obscureText: obscureText ?? false,
        cursorHeight: 20.h,
        style: appStyle(
            11, ThemeUtils.dynamicTextColor(context), FontWeight.normal),
        validator: validator,
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
              color: AppColors.primaryColor, // Replace with desired color
              width: 1.5.w, // Adjust thickness for focused state
            ),
          ),
          hintText: hintText,
          hintStyle: appStyle(
              11, ThemeUtils.dynamicTextColor(context), FontWeight.normal),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
