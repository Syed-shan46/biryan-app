import 'package:biriyani/features/authentication/controllers/auth_controller.dart';
import 'package:biriyani/features/authentication/screens/login/user_name_screen.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:phone_otp_verification/phone_verification.dart';

class PhoneVerificationPage extends ConsumerStatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  ConsumerState<PhoneVerificationPage> createState() =>
      _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends ConsumerState<PhoneVerificationPage> {
  late String verificationId;
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return PhoneVerification(
      isFirstPage: false,
      enableLogo: false,
      themeColor: Colors.blueAccent,
      backgroundColor: Colors.black,
      initialPageText: "Verify Phone Number",
      initialPageTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textColor: Colors.white,
      onSend: (String phoneNumber) async {
        // Trigger Firebase phone number verification
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {
            // Auto-sign-in (optional)
          },
          codeSent: (String id, int? resendToken) {
            setState(() {
              verificationId = id;
            });
          },
          verificationFailed: (FirebaseAuthException ex) {
            print('Verification failed: ${ex.message}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Verification failed: ${ex.message}')),
            );
          },
          codeAutoRetrievalTimeout: (String id) {
            print('Code auto-retrieval timeout: $id');
          },
        );
      },
      onVerification: (String otp) async {
        try {
          // Verify OTP using Firebase
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: otp,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);

          // Get the phone number and userId from Firebase Auth
          User? currentUser = FirebaseAuth.instance.currentUser;

          String userId = currentUser?.uid ?? ''; // Retrieve the UID

          // Get the phone number from Firebase Auth
          String phoneNumber =
              FirebaseAuth.instance.currentUser?.phoneNumber ?? '';

          if (phoneNumber.isNotEmpty) {
            // Check or create user in the database
            await authController.handleUserCheck(phoneNumber, ref);
          }

          // Navigate to the main menu
          Get.offAll(() => UsernamePage(
                phone: phoneNumber,
              ));
        } catch (e) {
          print('OTP verification failed: $e');
        }
      },
    );
  }
}
