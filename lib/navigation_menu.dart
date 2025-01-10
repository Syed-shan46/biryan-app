import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/features/shop/screens/home/home_screen.dart';
import 'package:biriyani/features/shop/screens/location.dart';
import 'package:biriyani/features/shop/screens/profile/profile_screen.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.h),
            child: GNav(
              activeColor: AppColors.primaryColor.withOpacity(0.8),
              tabActiveBorder: Border.all(color: AppColors.primaryColor),
              padding: EdgeInsets.all(6.h),
              selectedIndex: controller.selectedIndex.value,
              onTabChange: controller.changeTabIndex, // Use the method
              gap: 8,
              tabs: const [
                GButton(icon: Iconsax.home5, text: 'Home'),
                GButton(
                  icon: Iconsax.search_favorite,
                  text: 'Search',
                ),
                GButton(icon: Iconsax.shopping_cart, text: 'Cart'),
                GButton(icon: CupertinoIcons.person, text: 'Profile')
              ],
            ),
          ),
        ),
        body: controller.screens[controller.selectedIndex.value],
      );
    });
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const MyLocation(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
