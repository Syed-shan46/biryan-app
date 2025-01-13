import 'package:biriyani/features/authentication/controllers/auth_controller.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhoneUserNameScreen extends ConsumerStatefulWidget {
  const PhoneUserNameScreen({super.key});

  @override
  ConsumerState<PhoneUserNameScreen> createState() =>
      _PhoneUserNameScreenState();
}

class _PhoneUserNameScreenState extends ConsumerState<PhoneUserNameScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  AuthController authController = AuthController();

  bool _isSnackbarVisible = false;
  String _snackbarMessage = '';

  void showSnackbar(String message) {
    setState(() {
      _snackbarMessage = message;
      _isSnackbarVisible = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSnackbarVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            bottom: _isSnackbarVisible ? 20 : -100, // Slide in/out
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: _isSnackbarVisible ? 1 : 0, // Fade in/out
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wishlist Updated!',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      _isSnackbarVisible ? Icons.check_circle : Icons.error,
                      color: _isSnackbarVisible ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App Logo or Illustration

                    // Header Text
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "We are not currently using OTP (One-Time Password) for verification. Ensure the number is correct to avoid issues logging in.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Input Card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // Phone Number Input
                            Row(
                              children: [
                                // Phone Number Field
                                Expanded(
                                  child: TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      labelStyle: TextStyle(
                                          color: ThemeUtils.dynamicTextColor(
                                              context)),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      prefixIcon: Icon(Icons.phone,
                                          color: ThemeUtils.dynamicTextColor(
                                              context)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your phone number';
                                      } else if (value.length < 10) {
                                        return 'Enter a valid phone number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Username Input
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color:
                                        ThemeUtils.dynamicTextColor(context)),
                                labelText: 'Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: ThemeUtils.dynamicTextColor(context),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username is required';
                                } else if (value.length < 3) {
                                  return 'Username must be at least 3 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Terms and Conditions Checkbox
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.handleUserCheck(
                            phoneController.text,
                            usernameController.text,
                            ref,
                          );
                          Get.snackbar(
                              'Account', 'Account created successfully',
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.7));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: ThemeUtils.sameBrightness(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
