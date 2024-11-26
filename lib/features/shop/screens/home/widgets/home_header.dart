import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHeader extends StatefulWidget {
  const MyHeader({
    super.key,
  });

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    String userName = 'Deliver to';
    return Padding(
      padding: const EdgeInsets.only(left: MySizes.spaceBtwItems),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19.r,
            backgroundImage: const AssetImage('assets/images/man.png'),
          ),
          // Left side with welcome title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: MySizes.spaceBtwItems / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Adjusts height to fit content
                children: [
                  Text(
                    userName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    'Parakunnam  678001',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ThemeUtils.dynamicTextColor(context)),
                  ),
                ],
              ),
            ),
          ),
          // Cart icon on the right side
          Padding(
            padding: const EdgeInsets.only(
                right: MySizes.spaceBtwItems), // Consistent padding
            child: Text(
              getTimeOfDay(),
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return ' ☀️ ';
    } else if (hour >= 12 && hour < 16) {
      return ' ⛅ ';
    } else {
      return ' 🌙 ';
    }
  }
}
