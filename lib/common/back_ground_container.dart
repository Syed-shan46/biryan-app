import 'package:biriyani/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer(
      {super.key, required this.child, required this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/restaurant_bk.png",
            ),
            fit: BoxFit.cover,
            opacity: .7,
          )),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}