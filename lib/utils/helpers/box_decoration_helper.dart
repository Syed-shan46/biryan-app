// box_decoration_helper.dart
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

/// Returns a BoxDecoration based on the brightness of the theme.
BoxDecoration getDynamicBoxDecoration(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return BoxDecoration(
    color: isDarkMode
        ? Colors.blueGrey.withOpacity(0.1)
        : ThemeUtils.sameBrightness(context), // Base color for the box
    boxShadow: isDarkMode
        ? [] // No shadow in dark mode
        : [
            const BoxShadow(
              color: Color.fromRGBO(99, 99, 99, 0.2),
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],

    borderRadius: BorderRadius.circular(12), // Optional rounded corners
  );
}
