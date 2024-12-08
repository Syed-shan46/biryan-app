import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  // API call to update the user details (username, email)
  Future<void> editUser(String username, String email) async {
    final String apiUrl = 'http://10.0.2.2:3000/editUser'; // Replace with your API URL

    setState(() {
      isLoading = true;
      errorMessage = ''; // Reset error message
    });

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Show success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('User updated successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Failed to update user. Please try again.';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error updating user: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Validation for username and email
  bool isValidInput() {
    String username = usernameController.text;
    String email = emailController.text;
    
    if (username.isEmpty || email.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields.';
      });
      return false;
    }

    if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(email)) {
      setState(() {
        errorMessage = 'Please enter a valid email address.';
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Your Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (!isValidInput()) return;


                      String username = usernameController.text;
                      String email = emailController.text;

                      // Update user details in the backend
                      await editUser( username, email);
                    },
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
