import 'package:biriyani/utils/constants/global_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsernameController {
  static Future<bool> checkUsername(String phoneNumber) async {
    String formattedPhoneNumber =
        phoneNumber.startsWith('+') ? phoneNumber : '+$phoneNumber';
    print('Formatted phone number: $formattedPhoneNumber');
    final response = await http.get(
      Uri.parse(
          '$uri/check-username?phoneNumber=${Uri.encodeComponent(formattedPhoneNumber)}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Username exists: ${data['usernameExists']}'); // Log the response
      return data[
          'usernameExists']; // Return true if username exists, false otherwise
    } else {
      throw Exception('Failed to check username');
    }
  }
}
