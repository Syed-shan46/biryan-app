import 'package:biriyani/features/shop/controllers/home_controller.dart';
import 'package:biriyani/features/shop/screens/home/widgets/banner_widget.dart';
import 'package:biriyani/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBannerSlider extends StatefulWidget {
  const MyBannerSlider({super.key});

  @override
  State<MyBannerSlider> createState() => _MyBannerSliderState();
}

class _MyBannerSliderState extends State<MyBannerSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Carousel Slider
        CarouselSlider(
          options: CarouselOptions(
            height: 130.h,
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
            autoPlay: true,
          ),
          items: const [
            MyBannerWidget(
              imageUrl: 'assets/banners/bn-1.jpg',
            ),
            MyBannerWidget(
              imageUrl: 'assets/banners/bn-2.jpg',
            ),
            MyBannerWidget(
              imageUrl: 'assets/banners/bn-3.jpg',
            ),
          ].animate(delay: 400.ms).shimmer(
                duration: 1000.ms,
              ),
        ),
      ],
    );
  }
}
