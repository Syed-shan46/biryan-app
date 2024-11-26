// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedDescriptionWidget extends StatelessWidget {
  final Duration descriptionPlayDuration;
  final Duration descriptionDelayDuration;
  const AnimatedDescriptionWidget({
    super.key,
    required this.descriptionPlayDuration,
    required this.descriptionDelayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Text(
          'Chicken, mutton, veg, or exotic delights – we’ve got it all! Browse a variety of biryani options tailored to your taste',
          maxLines: 2,
          textAlign: TextAlign.center,
          style:
              textTheme.titleMedium!.copyWith(color: AppColors.darkTextColor),
        )
            .animate()
            .slideY(
                begin: 0.1,
                end: 0,
                delay: 350.ms + 400.ms,
                duration: descriptionPlayDuration,
                curve: Curves.easeInOutCubic)
            .scaleXY(
                begin: 0,
                end: 1,
                delay: descriptionDelayDuration,
                duration: descriptionPlayDuration,
                curve: Curves.easeInOutCubic));
  }
}
