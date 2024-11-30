import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key, required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(
            child: Divider(
                color: Colors.grey, thickness: 0.5, indent: 60, endIndent: 5)),
        Text(dividerText,
            style: TextStyle(fontSize: 12,color: ThemeUtils.dynamicTextColor(context))),
        const Flexible(
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
              indent: 5,
              endIndent: 60,
            )),
      ],
    );
  }
}
