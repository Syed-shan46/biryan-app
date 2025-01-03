import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedTitleWidget extends StatelessWidget {
  final Duration titleDelayDuration;
  final Duration mainPlayDuration;

  const AnimatedTitleWidget({
    super.key,
    required this.titleDelayDuration,
    required this.mainPlayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text.rich(
          TextSpan(
              style: textTheme.headlineMedium!
                  .copyWith(fontWeight: FontWeight.w500),
              children: const [
                TextSpan(
                  text: 'Hot Biriyani, Right at Your',
                  style: TextStyle(color: AppColors.darkTextColor),
                ),
                TextSpan(
                    text: ' Doorstep',
                    style: TextStyle(color: AppColors.primaryColor)),
              ]),
          textAlign: TextAlign.center,
        ),
      ),
    )
        .animate()
        .slideY(
            begin: -0.2,
            end: 0,
            delay: titleDelayDuration,
            duration: mainPlayDuration,
            curve: Curves.easeInOutCubic)
        .scaleXY(
            begin: 0,
            end: 1,
            delay: titleDelayDuration,
            duration: mainPlayDuration,
            curve: Curves.easeInOutCubic);
  }
}
