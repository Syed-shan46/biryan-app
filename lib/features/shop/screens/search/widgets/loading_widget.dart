import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: 725.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 180.h),
        child: LottieBuilder.asset("assets/images/delivery4.json",
            width: 375.w, height: 400,repeat: false,),
      ),
    );
  }
}
