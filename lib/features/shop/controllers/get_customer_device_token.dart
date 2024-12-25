import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> getCustomerDeviceToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Get the FCM token for the device
  String? token = await messaging.getToken();

  if (token != null) {
    print("Device Token: $token");
    return token; // Return the token
  } else {
    print("Failed to get device token");
    return ''; // Return an empty string or handle this case
  }
}
