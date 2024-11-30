import 'package:biriyani/common/custom_shapes/primary_header_container.dart';
import 'package:biriyani/common/text_forms/my_text_form_widget.dart';
import 'package:biriyani/features/authentication/screens/register/register.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFormFields extends StatefulWidget {
  const MyFormFields({
    super.key,
  });

  @override
  State<MyFormFields> createState() => _MyFormFieldsState();
}

class _MyFormFieldsState extends State<MyFormFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Login method

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email TextField
          MyTextField(

              // Validating
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              labelText: 'Email',
              icon: Iconsax.direct_right),
          const SizedBox(height: MySizes.spaceBtwItems),

          // Password TextField
          MyTextField(
              labelText: 'Password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your Password';
                }
                return null;
              },
              icon: Iconsax.password_check),
          const SizedBox(height: MySizes.spaceBtwItems / 2),

          // Remember me & Forgot Password
          const RememberMePassword(),
          const SizedBox(height: MySizes.spaceBtwSections),

          // Sign in Button
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              onPressed: () async {},
              child: Text(
                'Login',
                style: TextStyle(
                  color: ThemeUtils.sameBrightness(context),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: MySizes.spaceBtwItems),

          // Create account  Button
          const CreateAccount(),
        ],
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: ThemeUtils.dynamicTextColor(context).withOpacity(0.8)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        onPressed: () => Get.to(() => const SignUpScreen()),
        child:  Text(
          'Create Account',
          style: TextStyle(
            color: ThemeUtils.dynamicTextColor(context),
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class RememberMePassword extends StatefulWidget {
  const RememberMePassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RememberMePasswordState createState() => _RememberMePasswordState();
}

class _RememberMePasswordState extends State<RememberMePassword> {
  bool _rememberMe = false; // Initial state

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Remember me
        Row(
          children: [
            Checkbox(
              
              value: _rememberMe,
              side: BorderSide(color: ThemeUtils.dynamicTextColor(context)),
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!; // Toggle the value
                });
              },
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
            ),
            const Text('Remember me?'),
          ],
        ),

        /// Forgot password
        TextButton(
          onPressed: () {
            // Handle forgot password
          },
          child: const Text(
            'Forgot Password',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
