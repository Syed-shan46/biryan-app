import 'package:biriyani/features/shop/controllers/navigation_controller.dart';
import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/features/shop/screens/home/home_screen.dart';
import 'package:biriyani/features/shop/screens/profile/profile_screen.dart';
import 'package:biriyani/features/shop/screens/search/search_screen.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

List<Widget> pageList = const [
  HomeScreen(),
  SearchScreen(),
  CartScreen(),
  ProfileScreen()
];

class _NavigationMenuState extends State<NavigationMenu> {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            pageList[controller.tabIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                  data: Theme.of(context).copyWith(
                      canvasColor: AppColors.primaryColor.withOpacity(0.8)),
                  child: BottomNavigationBar(
                      onTap: (value) {
                        controller.setTabIndex = value;
                      },
                      currentIndex: controller.tabIndex,
                      unselectedIconTheme:
                          const IconThemeData(color: Colors.black38),
                      selectedIconTheme:
                          const IconThemeData(color: Colors.white),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.search), label: 'Search'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.shopping_cart), label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Icon(FontAwesome.user_circle_o),
                            label: 'Home')
                      ])),
            )
          ],
        ),
      );
    });
  }
}
