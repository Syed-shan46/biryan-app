import 'package:biriyani/features/authentication/controllers/auth_controller.dart';
import 'package:biriyani/features/authentication/controllers/username_controller.dart';
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
// Retrieve the UID

          // Get the phone number from Firebase Auth
          String phoneNumber =
              FirebaseAuth.instance.currentUser?.phoneNumber ?? '';

          if (phoneNumber.isNotEmpty) {
            // Check if the username exists for this phone number
            print(phoneNumber);
            bool usernameExists =
                await UsernameController.checkUsername(phoneNumber);
            print('Username exists: $usernameExists'); // Debugging line
            if (usernameExists) {
              print(
                  'User already has a username. Proceeding to the main menu.');
              Get.offAll(() =>
                  const NavigationMenu()); // Replace with your actual screen
            } else {
              print(
                  'No username found. Redirecting to the username creation screen.');
              Get.offAll(() => UsernamePage(phone: phoneNumber));
            }
          } else {
            print('Otp verification failed.');
          }

          // Navigate to the username screen if no username exists
        } catch (e) {
          print('OTP verification failed: $e');
        }
      },
    );
  }
}

// bool usernameExists =
//                 await UsernameController.checkUsername(phoneNumber);
//             print('Username exists: $usernameExists'); // Debugging line
//             if (usernameExists) {
//               print(
//                   'User already has a username. Proceeding to the main menu.');
//               Get.offAll(() =>
//                   const NavigationMenu()); // Replace with your actual screen
//             } else {
//               print(
//                   'No username found. Redirecting to the username creation screen.');
//               Get.offAll(() => UsernamePage(phone: phoneNumber));
//             }

// controller
Future<void> handleUserCheck(String phoneNumber, WidgetRef ref) async {
  try {
    // Check if the user already exists in the database
    bool usernameExists = await UsernameController.checkUsername(phoneNumber);

    if (usernameExists) {
      // User already has a username, proceed to the main menu or home screen
      print('User exists, proceeding to the main menu.');
      // Navigate to the main menu or home screen after successful login
      Get.offAll(
          () => const NavigationMenu()); // Replace with your actual screen
    } else {
      // User doesn't have a username, redirect them to the username creation screen
      print('No username found. Redirecting to the username creation screen.');
      Get.offAll(() => UsernamePage(
            phone: phoneNumber,
          ));
    }
  } catch (error) {
    print('Error in checking user: $error');
  }
}


// Future<void> getLocation() async {
//     try {
//       // Get current position
//       LocationSettings locationSettings = const LocationSettings(
//         accuracy: LocationAccuracy.bestForNavigation, // Best GPS accuracy
//       );

//       // Get the current position
//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: locationSettings,
//       );

//       setState(() {
//         coordinates =
//             'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//       });

//       // Reverse geocoding with Nominatim
//       String url =
//           "https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&key=$apiKey";
//       var response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         setState(() {
//           address = data['display_name'] ?? 'No address found';
//         });
//       } else {
//         setState(() {
//           address = 'Failed to fetch address';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         address = 'Error: ${e.toString()}';
//       });
//     }
//   }