import 'package:biriyani/common/app_style.dart';
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          child: SizedBox(
            height: 40.h,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Center(
                      child: AnimatedTextWidget(
                          buttonPlayDuration: buttonPlayDuration,
                          buttonDelayDuration: buttonDelayDuration),
                    ))
                .animate()
                .slideY(
                    begin: 5,
                    end: 0,
                    delay: buttonDelayDuration,
                    duration: buttonPlayDuration,
                    curve: Curves.easeInOutCubic),
          ),
        )
      ],
    );
  }
}

class AnimatedTextWidget extends StatelessWidget {
  final Duration buttonPlayDuration;
  final Duration buttonDelayDuration;
  const AnimatedTextWidget({
    Key? key,
    required this.buttonPlayDuration,
    required this.buttonDelayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: Text('Get Started',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: appStyle(14, Colors.white, FontWeight.normal)),
    ).animate().scaleXY(
        begin: 0,
        end: 1,
        delay: buttonDelayDuration + 300.ms,
        duration: buttonPlayDuration,
        curve: Curves.easeInOutCubic);
  }
}
