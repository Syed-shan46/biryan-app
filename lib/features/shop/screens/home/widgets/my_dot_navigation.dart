import 'package:biriyani/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:biriyani/features/shop/controllers/home_controller.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                  height: 5,
                  width: 15,
                  decoration: BoxDecoration(
                    color: controller.carousalCurrentIndex.value == i
                        ? AppColors.primaryColor
                        : Colors.grey,
                    borderRadius: i == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          )
                        : i == dotCount - 1
                            ? const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )
                            : BorderRadius.zero,
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
