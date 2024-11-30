import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

import 'circular_container.dart';
import 'curved_edges_widget.dart';

class MyPrimaryHeaderContainer extends StatelessWidget {
  const MyPrimaryHeaderContainer({
    super.key,
    required this.child,
    this.showContainer = true,
    required this.color,
  });

  final Widget child;
  final bool showContainer;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return MyCurvedWidget(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: MySizes.spaceBtwItems),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Stack(
          children: [
            showContainer
                ? Positioned(
                    top: -70,
                    right: -70,
                    child: MyCircularContainer(
                      width: 205,
                      height: 205,
                      radius: 400,
                      backgroundColor: isDarkMode
                          ? const Color.fromARGB(255, 31, 30, 30)
                          : ThemeUtils.sameBrightness(context).withOpacity(0.1),
                    ),
                  )
                : const SizedBox(
                    height: null,
                  ),
            showContainer
                ? Positioned(
                    top: -70,
                    right: -25,
                    child: MyCircularContainer(
                        width: 205,
                        height: 205,
                        radius: 400,
                        backgroundColor: ThemeUtils.sameBrightness(context)
                            .withOpacity(0.1)),
                  )
                : const SizedBox(
                    height: null,
                  ),
            child,
          ],
        ),
      ),
    );
  }
}

class DynamicBg {
  static sameBrightness(BuildContext context) {}
}
