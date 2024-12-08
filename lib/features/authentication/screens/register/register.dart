import 'package:biriyani/common/text_forms/my_text_form_widget.dart';
import 'package:biriyani/features/authentication/screens/login/widgets/divider.dart';
import 'package:biriyani/features/authentication/screens/login/widgets/social_icons.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String userName;
  late String email;
  late String password;
  bool isChecked = false;

  // Controllers
  final  emailController = TextEditingController();
  final  passWordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passWordController.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passWordController.text.trim(),
      );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text("Let's create your account",
                  style: textTheme.headlineMedium),

              const SizedBox(height: MySizes.spaceBtwSections),

              /// form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// Username

                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// Email
                    MyTextField(
                     controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      labelText: 'Email',
                      icon: Iconsax.user_edit,
                    ),
                    const SizedBox(height: MySizes.spaceBtwInputFields),

                    /// password
                    MyTextField(
                      controller: passWordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      labelText: 'Password',
                      icon: Iconsax.password_check,
                      showSuffixIcon: true,
                    ),
                    const SizedBox(height: MySizes.spaceBtwSections),

                    /// Terms and  Conditions Checkbox
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            side: BorderSide(
                                color: ThemeUtils.dynamicTextColor(context)),
                            activeColor: AppColors.primaryColor,
                            value: isChecked,
                            checkColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!; // Toggle the value
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: MySizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'I agree to',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                text: 'Privacy policy',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryColor,
                                    ),
                              ),
                              TextSpan(
                                  text: '&',
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                text: 'Terms of Use',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.primaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              // sign up button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  onPressed: () async {
                    await createUserWithEmailAndPassword();
                  },
                  child: Text('Create Account',
                      style: TextStyle(
                          color: ThemeUtils.dynamicTextColor(context),
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwSections),

              /// divider
              const MyDivider(dividerText: 'or sign in with'),
              const SizedBox(height: MySizes.spaceBtwItems),

              /// social buttons
              const MySocialIcons(),
            ],
          ),
        ),
      ),
    );
  }
}
