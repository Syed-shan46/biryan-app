import 'dart:convert';
import 'package:biriyani/features/shop/controllers/user_location_controller.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  final Color myColor = const Color.fromRGBO(128, 178, 247, 1);
  String coordinates = "No Location found";
  String address = 'No Address found';
  bool scanning = false;

  LatLng? currentLocation; // For map center and marker

  // Check permissions and fetch location
  Future<void> checkPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location services are disabled.');
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Location permissions are permanently denied.');
      return;
    }

    getLocation();
  }

  // Get the current location and update the UI
  Future<void> getLocation() async {
    setState(() {
      scanning = true;
    });

    try {
      // Use locationSettings for specifying accuracy
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      );

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        coordinates =
            'Latitude: ${position.latitude} \nLongitude: ${position.longitude}';
      });

      // Call Nominatim API to get address
      await fetchAddressFromNominatim(position.latitude, position.longitude);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      print("Error: ${e.toString()}");
    }

    setState(() {
      scanning = false;
    });
  }

  // Fetch address using Nominatim API
  Future<void> fetchAddressFromNominatim(
      double latitude, double longitude) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          address = data['display_name'] ?? 'No Address Found';
        });
      } else {
        Fluttertoast.showToast(msg: 'Failed to fetch address from Nominatim.');
        print('Error: ${response.body}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String userName = 'Deliver to';
    return Padding(
      padding: EdgeInsets.only(left: 12.w, top: 5.h, bottom: 2.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19.r,
            backgroundImage: const AssetImage('assets/images/man.png'),
          ),
          // Left side with welcome title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: MySizes.spaceBtwItems / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Adjusts height to fit content
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  scanning
                      ? const SpinKitThreeBounce(
                          color: AppColors.primaryColor, size: 10)
                      : Text(
                          address,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
          ),
          // Cart icon on the right side
          Padding(
            padding: const EdgeInsets.only(right: 5), // Consistent padding
            child: Text(
              getTimeOfDay(),
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return ' ☀️ ';
    } else if (hour >= 12 && hour < 16) {
      return ' ⛅ ';
    } else {
      return ' 🌙 ';
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final controller = Get.put(UserLocationController());
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    controller.setPosition(currentLocation);
    controller.getUserAddress(currentLocation);
    print(currentLocation);
  }
}
