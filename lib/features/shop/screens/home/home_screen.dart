import 'package:biriyani/common/heading.dart';
import 'package:biriyani/features/shop/screens/home/widgets/banner_slider.dart';
import 'package:biriyani/features/shop/screens/home/widgets/category_list.dart';
import 'package:biriyani/features/shop/screens/home/widgets/home_header.dart';
import 'package:biriyani/features/shop/screens/home/widgets/food_list.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h), child: const HomeHeader()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: const CategoryList(),
              ),
              const SizedBox(height: MySizes.spaceBtwItems / 2),
              const MyBannerSlider(),
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
