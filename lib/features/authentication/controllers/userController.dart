import 'package:get/get.dart';

class UserController extends GetxController {
  // Declare a reactive variable for the username
  var username = ''.obs;

  // Method to update the username
  void updateUsername(String newUsername) {
    username.value = newUsername;
  }
}
