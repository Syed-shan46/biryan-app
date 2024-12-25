import 'package:biriyani/common/app_style.dart';
import 'package:biriyani/features/shop/controllers/user_location_controller.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    _determinePosition();
  }

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserLocationController());
    String userName = 'Deliver to';
    return Padding(
      padding: EdgeInsets.only(left: 12.w,top: 5.h,bottom: 2.h),
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
                        fontWeight: FontWeight.w600),
                  ),
                   Obx(
                        () => SizedBox(
                          width: 375.w * 0.65,
                          child: Text(controller.address == ""
                              ? "16768 21st Ave N, Plymouth, MN 55447" : controller.address,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  appStyle(11, Colors.grey, FontWeight.normal)),
                        ),
                      )
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
    LatLng currentLocation = LatLng(position.latitude,position.longitude);
    controller.setPosition(currentLocation);
    controller.getUserAddress(currentLocation);
    print(currentLocation);
  }
}


