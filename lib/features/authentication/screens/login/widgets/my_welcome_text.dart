import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';

class MyWelcomeText extends StatelessWidget {
  const MyWelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Biriyani!',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: MySizes.spaceBtwItems / 2),
        const Text(
            'To keep connected with us please login with your personal info'),
      ],
    );
  }
}
