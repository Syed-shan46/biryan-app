import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  // API call to create the user in the backend
  Future<void> handleUserCheck(String phoneNumber, WidgetRef ref) async {
    const String apiUrl = 'http://10.0.2.2:3000/checkUser';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'phone': phoneNumber}),
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
          icon: Icon(Icons.logout), backgroundColor: AppColors.accentColor);
    } catch (e) {
      // Show error message in case of any issues
      Get.snackbar('Error', 'Error signing out: $e');
    }
  }
}
