import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/features/shop/screens/home/home_screen.dart';
import 'package:biriyani/features/shop/screens/profile/profile_screen.dart';
import 'package:biriyani/features/shop/screens/search/search_screen.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final  controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(()=>
         NavigationBar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.9),
          indicatorColor: Colors.black.withOpacity(0.7),

            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index)=> controller.selectedIndex.value = index,
            destinations: const [
              
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home',),
              NavigationDestination(
                  icon: Icon(Iconsax.search_favorite), label: 'Search'),
              NavigationDestination(
                  icon: Icon(Iconsax.shopping_cart), label: 'Cart'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],),
            
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = const [ 
     HomeScreen(),
     SearchScreen(),
     CartScreen(),
     ProfileScreen(),
  ];
}
