import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPermission();
  }

  final Color myColor = const Color.fromRGBO(128, 178, 247, 1);

  String coordinates = "No Location found";
  String address = 'No Address found';
  bool scanning = false;

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    print(serviceEnabled);

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Request Denied !');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Denied Forever !');
      return;
    }

    getLocation();
  }

  Future<void> getLocation() async {
    setState(() {
      scanning = true;
    });

    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy:
            LocationAccuracy.bestForNavigation, // Specify the desired accuracy
        distanceFilter:10, // Minimum distance (in meters) a device must move horizontally before an update is generated
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      print("Location retrieved: ${position.latitude}, ${position.longitude}");

      setState(() {
        coordinates =
            'Latitude: ${position.latitude} \nLongitude: ${position.longitude}';
      });

      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (result.isNotEmpty) {
        setState(() {
          address =
              '${result[0].name}, ${result[0].locality}, ${result[0].administrativeArea}';
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      print("Error: ${e.toString()}");
    }

    setState(() {
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Current Coordinates',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          scanning
              ? SpinKitThreeBounce(
                  color: myColor,
                  size: 20,
                )
              : Text(
                  '${coordinates}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Current Address',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
          const SizedBox(
            height: 20,
          ),
          scanning
              ? SpinKitThreeBounce(
                  color: myColor,
                  size: 20,
                )
              : Text(
                  '$address',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
          const Spacer(),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                checkPermission();
              },
              icon: const Icon(
                Icons.location_pin,
                color: Colors.white,
              ),
              label: const Text(
                'Current Location',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: myColor,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
