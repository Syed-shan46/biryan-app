import 'package:biriyani/common/heading.dart';
import 'package:biriyani/features/shop/controllers/home_controller.dart';
import 'package:biriyani/features/shop/screens/home/widgets/banner_slider.dart';
import 'package:biriyani/features/shop/screens/home/widgets/category_list.dart';
import 'package:biriyani/features/shop/screens/home/widgets/home_header.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_list.dart';
import 'package:biriyani/features/shop/screens/home/widgets/my_dot_navigation.dart';
import 'package:biriyani/utils/animation/page_transition.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h), child: const HomeHeader()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NoTransitionAnimation(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: const CategoryList(),
                ),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              const MyBannerSlider(),
              MyDotNavigation(controller: controller, dotCount: 3),
              const Heading(title: 'Popular Items'),
              const FoodList(),
              const Heading(title: 'Trending Now'),
              const FoodList(),
              const Heading(title: 'Top Picks for you'),
              const FoodList(),
            ],
          ),
        ),
      ),
    );
  }
}
