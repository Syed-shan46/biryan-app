import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

class MySettingsMenuTile extends StatelessWidget {
  const MySettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      this.trailing,
      this.isRed = false,
      this.onTap});

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.withOpacity(0.1)
            : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
          color: isRed
              ? Colors.red
              : ThemeUtils.dynamicTextColor(context).withOpacity(0.8),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: isRed
                  ? Colors.red
                  : ThemeUtils.dynamicTextColor(context).withOpacity(0.8)),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
