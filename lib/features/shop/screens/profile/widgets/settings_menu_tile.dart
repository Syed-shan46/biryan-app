import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

class MySettingsMenuTile extends StatelessWidget {
  const MySettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: ThemeUtils.dynamicTextColor(context).withOpacity(0.8),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: ThemeUtils.dynamicTextColor(context).withOpacity(0.8)),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: ThemeUtils.dynamicTextColor(context).withOpacity(0.6)),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
