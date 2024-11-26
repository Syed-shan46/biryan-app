import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedButtonWidget extends StatelessWidget {
  final Duration buttonDelayDuration;
  final Duration buttonPlayDuration;
  const AnimatedButtonWidget({
    super.key,
    required this.buttonDelayDuration,
    required this.buttonPlayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.spaceBtwItems),
      child: SizedBox(
        height: 40.h,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
          onPressed: () {},
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
    );
  }
}

class AnimatedTextWidget extends StatelessWidget {
  final Duration buttonPlayDuration;
  final Duration buttonDelayDuration;
  const AnimatedTextWidget({
    super.key,
    required this.buttonPlayDuration,
    required this.buttonDelayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Text('Get Started',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.lightBackground,fontWeight: FontWeight.w500))
        .animate()
        .scaleXY(
            begin: 0,
            end: 1,
            delay: buttonDelayDuration + 300.ms,
            duration: buttonPlayDuration,
            curve: Curves.easeInOutCubic);
  }
}
