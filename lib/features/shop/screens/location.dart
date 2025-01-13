import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final Color myColor = const Color.fromRGBO(128, 178, 247, 1);
  String coordinates = "No Location found";
  String address = 'No Address found';
  bool scanning = false;

  LatLng? currentLocation; // For map center and marker

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

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
    return Scaffold(
      appBar: AppBar(title: const Text('My Location with OSM')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Current Coordinates',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          scanning
              ? SpinKitThreeBounce(color: myColor, size: 20)
              : Text(
                  coordinates,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          const SizedBox(height: 20),
          const Text(
            'Current Address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          scanning
              ? SpinKitThreeBounce(color: myColor, size: 20)
              : Text(
                  address,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: currentLocation == null
                ? const Center(child: Text('Fetching map...'))
                : FlutterMap(
                    options: MapOptions(
                      initialCenter: currentLocation!,
                      initialZoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: 'com.biriyani.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: currentLocation!,
                            width: 50.0,
                            height: 50.0,
                            rotate: true,
                            child: const Icon(
                              Icons.location_pin,
                              size: 50.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              checkPermission();
            },
            icon: const Icon(Icons.location_pin, color: Colors.white),
            label: const Text(
              'Update Location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: myColor),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
