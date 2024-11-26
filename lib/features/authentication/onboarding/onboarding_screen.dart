import 'dart:async';

import 'package:biriyani/features/authentication/onboarding/widgets/animated_button_widget.dart';
import 'package:biriyani/features/authentication/onboarding/widgets/animated_description_widget.dart';
import 'package:biriyani/features/authentication/onboarding/widgets/animated_dish_widget.dart';
import 'package:biriyani/features/authentication/onboarding/widgets/animated_title_widget.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainPlayDuration = 1000.ms;
    final leavesDelayDuration = 600.ms;
    final titleDelayDuration = mainPlayDuration + 50.ms;
    final descriptionDelayDuration = titleDelayDuration + 300.ms;
    final buttonDelayDuration = mainPlayDuration + 200.ms;
    final buttonPlayDuration = mainPlayDuration - 200.ms;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: MySizes.spaceBtwSections),
          // Top Image
          Flexible(
            flex: 6,
            child: AnimatedDishWidget(
              dishPlayDuration: mainPlayDuration,
              leavesDelayDuration: leavesDelayDuration,
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),
          // Title
          Flexible(
            flex: 2,
            child: AnimatedTitleWidget(
              titleDelayDuration: titleDelayDuration,
              mainPlayDuration: mainPlayDuration,
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),
          // Description
          Flexible(
            flex: 1,
            child: AnimatedDescriptionWidget(
              descriptionPlayDuration: descriptionDelayDuration,
              descriptionDelayDuration: descriptionDelayDuration,
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwSections),
          Flexible(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                _controller.forward();
                _controller.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    Future.delayed(400.ms, () {
                      Get.toNamed('/home');
                    });
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.spaceBtwItems),
                child: SizedBox(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {
                      _controller.forward();
                      _controller.addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          Future.delayed(400.ms, () {
                            Get.offAllNamed('/home');
                          });
                        }
                      });
                    },
                    child: AnimatedTextWidget(
                        buttonPlayDuration: buttonPlayDuration,
                        buttonDelayDuration: buttonDelayDuration),
                  ).animate().scaleY(
                      begin: 0,
                      end: 1,
                      delay: buttonDelayDuration,
                      duration: buttonPlayDuration,
                      curve: Curves.easeInOutCubic),
                ),
              ),
            ),
          ),
        ],
      )
          .animate(
            autoPlay: false,
            controller: _controller,
          )
          .blurXY(begin: 0, end: 25, duration: 600.ms, curve: Curves.easeInOut)
          .scaleXY(begin: 1, end: 0.6)
          .fadeOut(
            begin: 1,
          ),
    );
  }
}
