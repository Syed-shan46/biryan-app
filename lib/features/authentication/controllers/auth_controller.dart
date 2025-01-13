import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  // API call to create the user in the backends
  Future<void> handleUserCheck(
      String phoneNumber, username, WidgetRef ref) async {
    String apiUrl = '$uri/checkUser';

    try {
      String? userDeviceToken = await FirebaseMessaging.instance.getToken();
      print('userDeviceToken:$userDeviceToken');
      if (userDeviceToken == null) {
        print('Unable to retrieve device token.');
        return;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'phone': phoneNumber,
          'userDeviceToken': userDeviceToken,
          'username': username,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);

        // Check if 'user' and 'token' exist in the response
        final userJson = responseBody['user'];
        final token = responseBody['token'];

        if (userJson != null && token != null) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString('auth_token', token);
          await preferences.setString('user', jsonEncode(userJson));
          ref.read(userProvider.notifier).setUser(jsonEncode(userJson));
          Get.to(() => const NavigationMenu());
          print('User set to state: $userJson');
        } else {
          print('User or token is null in response');
        }
      } else {
        print('Failed to check/create user: ${response.statusCode}');
      }
    } catch (error) {
      print('Error handling user: $error');
    }
  }

  Future<void> signOutUser({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      // Clear the token and user data from SharedPreferences
      await preferences.remove('auth_token');
      await preferences.remove('user');

      // Reset the user and order states
      ref.read(userProvider.notifier).signOut();

      // Navigate to LoginScreen and clear navigation stack

      // Show success message
      Get.snackbar('Logout', 'Logout Successfully',
          icon: const Icon(Icons.logout),
          backgroundColor: AppColors.primaryColor.withOpacity(0.7));
    } catch (e) {
      // Show error message in case of any issues
      Get.snackbar('Error', 'Error signing out: $e');
    }
  }

  Future<void> updateUsername(String userId, String username) async {
    String apiUrl = '$uri/updateUsername'; // Replace with your API URL

    try {
      // Construct the request body
      final Map<String, dynamic> requestBody = {
        'userId': userId,
        'username': username,
      };

      // Send the PATCH request
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Username updated successfully: ${responseData['user']}');
      } else {
        print('Failed to update username: ${response.body}');
      }
    } catch (error) {
      print('Error occurred while updating username: $error');
    }
  }
}
