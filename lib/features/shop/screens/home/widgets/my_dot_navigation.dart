import 'package:biriyani/features/shop/controllers/home_controller.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDotNavigation extends StatelessWidget {
  final int dotCount;
  const MyDotNavigation(
      {super.key, required this.controller, required this.dotCount});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < dotCount; i++)
                Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.carousalCurrentIndex.value == i
                        ? AppColors.primaryColor
                        : Colors.grey,
                  ),
                  margin: const EdgeInsets.only(right: 10),
                )
            ],
          ),
        )
      ],
    );
  }
}
