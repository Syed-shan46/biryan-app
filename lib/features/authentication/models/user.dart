import 'dart:convert';

class User {
  final String id; // User ID, which could be generated by the backend
  final String phone;
  final String userName;
  final String? userDeviceToken;
  // User's phone number

  // Constructor
  User({
    required this.id,
    required this.phone,
    required this.userName,
    this.userDeviceToken,
  });

  // Converts the User object to a Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id, // Map the 'id' field
      "phone": phone, // Map the 'phone' field
      "userName": userName,
      'userDeviceToken': userDeviceToken,
    };
  }

  // Encodes the Map into a JSON string
  String toJson() => json.encode(toMap());

  // Factory method to create a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ??
          "", // Use '_id' for compatibility with MongoDB
      phone:
          map['phone'] as String? ?? "", // Extract 'phone' field from the map
      userName: map['username'] as String? ?? "",
      userDeviceToken: map['userDeviceToken'] as String? ?? "", // Extract 'deviceToken' field
    );
  }

  // Factory method to create a User object from a JSON string
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
