import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsernamePage extends ConsumerStatefulWidget {
  final String phone;

  const UsernamePage({required this.phone, Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;
  bool _usernameExists = false;
  String title = ""; // Initialize title as an empty string

  @override
  void initState() {
    super.initState();
    _checkIfUsernameExists();
  }

  Future<void> _checkIfUsernameExists() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            '$uri/check-username?phoneNumber=${Uri.encodeComponent(widget.phone)}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _usernameExists = data['usernameExists'];
          if (_usernameExists) {
            _usernameController.text = data['username'] ?? '';
          }
          title = _usernameExists
              ? "Update Username"
              : "Create Username"; // Update title dynamically
        });
      } else {
        throw Exception('Failed to check username');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking username: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateOrCreateUsername() async {
    String username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        _errorText = "Username cannot be empty.";
      });
    } else if (username.length < 3) {
      setState(() {
        _errorText = "Username must be at least 3 characters.";
      });
      return;
    } else {
      setState(() {
        _errorText = null;
      });
    }

    final String apiUrl =
        _usernameExists ? '$uri/updateUsername' : '$uri/createUsername';

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

      if (response.statusCode == 200) {
        ref
            .read(userProvider.notifier)
            .updateUsername(username); // Update state management logic

        Get.snackbar(
          'Username',
          _usernameExists
              ? "Username updated successfully"
              : "Username created successfully",
        );

        Get.offAll(() => const NavigationMenu());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to ${_usernameExists ? "update" : "create"} username: ${response.body}')),
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
        title: Text(
          title.isEmpty ? "Loading..." : title, // Display dynamic title
          style: const TextStyle(
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
              Text(
                _usernameExists ? "Update your username" : "Create a username",
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _usernameExists
                    ? "You already have a username, update it to continue."
                    : "Create a new username to personalize your experience.",
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
                        onPressed: _updateOrCreateUsername,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeUtils.dynamicTextColor(context),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _usernameExists
                              ? 'Update'
                              : 'Create', // Button text update
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
              _usernameExists
                  ? ElevatedButton(
                      onPressed: () {
                        Get.to(() => const NavigationMenu());
                      },
                      child: const Text('Go to home'))
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}



