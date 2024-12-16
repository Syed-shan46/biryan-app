// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:biriyani/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class UserLocationController extends GetxController {
  LatLng position = const LatLng(0, 0);

  void setPosition(LatLng value) {
    value = position;
    update();
  }

  RxString _address = ''.obs;

  String get address => _address.value;

  set setAddress(String value) {
    _address.value = value;
  }

  RxString _postalCode = ''.obs;

  String get postalCode => _postalCode.value;

  set setPostalCode(String value) {
    _postalCode.value = value;
  }

  void getUserAddress(LatLng position) async {
  try {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey');

    print("Geocoding API Request URL: $url");

    final response = await http.get(url);
    print("API Response Status: ${response.statusCode}");
    print("API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      if (responseBody['results'] != null && responseBody['results'].isNotEmpty) {
        final address = responseBody['results'][0]['formatted_address'];
        setAddress = address;
        print("Address found: $address");
      } else {
        setAddress = "Unable to determine address.";
        print("Error: No results found in Google Geocoding API response.");
      }
    } else {
      setAddress = "Failed to fetch address (status: ${response.statusCode})";
      print("Error: API returned status code ${response.statusCode}");
    }
  } catch (e) {
    setAddress = "An error occurred while fetching the address.";
    print("Error: ${e.toString()}");
  }
}


}
