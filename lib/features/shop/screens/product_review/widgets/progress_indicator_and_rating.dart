import 'package:biriyani/utils/device/device_utility.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyRatingProgressIndicator extends StatelessWidget {
  const MyRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(flex: 11,child: SizedBox( 
          width: MyDeviceUtils.getScreenWidth(context) * 0.8,
          child: LinearProgressIndicator( 
            value: value,
            minHeight: 10,
            backgroundColor: Colors.grey,
            borderRadius: BorderRadius.circular(7),
            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor.withOpacity(0.8)),
          ),
        ))
      ],
    );
  }
}
