import 'package:biriyani/features/authentication/screens/login/widgets/divider.dart';
import 'package:biriyani/features/authentication/screens/login/widgets/social_icons.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/my_form_fields.dart';
import 'widgets/my_welcome_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              // Welcome Text, TextFields, Buttons & Social Icons
              Padding(
                padding: const EdgeInsets.all(MySizes.defaultSpace),
                child: Column(
                  children: [
                    // Welcome Text
                    const MyWelcomeText(),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    // FormFields
                    const MyFormFields(),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    // Divider
                    const MyDivider(dividerText: 'OR CONTINUE WITH'),
                    const SizedBox(height: MySizes.spaceBtwItems),

                    // Social Icons
                    const MySocialIcons(),
                    TextButton(
                        onPressed: () {
                          Get.to(() => const NavigationMenu());
                        },
                        child: const Text('Explore Now'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
