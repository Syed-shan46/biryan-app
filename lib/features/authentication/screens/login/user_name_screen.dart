import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsernamePage extends StatefulWidget {
  final String phone;

  const UsernamePage({required this.phone, Key? key}) : super(key: key);

  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  Future<void> _updateUsername() async {
    String username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        _errorText = "Username cannot be empty.";
      });
    } else if (username.length < 3) {
      setState(() {
        _errorText = "Username must be at least 3 characters.";
      });
    } else {
      // Clear error
      setState(() {
        _errorText = null;
      });
    }

    final String apiUrl = '$uri/updateUsername';

    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username cannot be empty')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        body: {
          'phone': widget.phone, // Pass phone number
          'username': _usernameController.text,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username updated successfully')),
        );

        Get.offAll(() => const NavigationMenu());

        // Navigate back or to a different page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to update username: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating username: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Create Username",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Let's Get Started!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Create a username to personalize your experience.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 16),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: "Enter a username",
                  hintStyle:
                      TextStyle(color: ThemeUtils.dynamicTextColor(context)),
                  hintText: "e.g., johndoe123",
                  labelStyle: TextStyle(color: Colors.grey[700]),
                  prefixIcon:
                      const Icon(Icons.person, color: AppColors.accentColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  errorText: _errorText,
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _updateUsername,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeUtils.dynamicTextColor(context),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 16,
                              color: ThemeUtils.sameBrightness(context)),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Text(
                "By continuing, you agree to our Terms & Conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
