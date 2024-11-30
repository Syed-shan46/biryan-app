import 'package:biriyani/common/custom_shapes/primary_header_container.dart';
import 'package:biriyani/features/authentication/screens/login/login.dart';
import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/features/shop/screens/profile/widgets/settings_menu_tile.dart';
import 'package:biriyani/features/shop/screens/profile/widgets/user_profile_tile.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          MyPrimaryHeaderContainer(
            showContainer: false,
            color: AppColors.primaryColor,
            child: SafeArea(
              child: Column(
                children: [
                  UserProfileTile(
                    onPressed: () {
                      Get.snackbar(' Login', "Please login to continue 😊",
                          backgroundColor:
                              AppColors.lightBackground.withOpacity(0.6));
                    },
                  ),
                  const SizedBox(
                    height: MySizes.spaceBtwItems,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(MySizes.spaceBtwItems),
            child: Column(
              children: [
                // Menu tiles
                const InkWell(
                  child: MySettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'My Address',
                      subTitle: 'Shopping delivery address'),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.to(() => const CartScreen()),
                  child: const MySettingsMenuTile(
                      icon: Iconsax.shopping_bag,
                      title: 'My Cart',
                      subTitle: 'Add, Remove products and move to checkout'),
                ),
                InkWell(
                  onTap: () {},
                  child: const MySettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders'),
                ),
                const MySettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account'),
                const MySettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all discounted Coupons'),
                const MySettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification message'),
                const MySettingsMenuTile(
                  icon: Iconsax.security_card,
                  title: 'Account Privacy',
                  subTitle: 'Manage data usage and connected accounts',
                ),

                const SizedBox(height: MySizes.spaceBtwItems),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.withOpacity(0.8),
                        side: const BorderSide(
                          color: Colors.blueAccent,
                        )),
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                      // Logout logic

                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return Container(
                      //       width: MediaQuery.of(context).size.width,
                      //       height: 120.h,
                      //       decoration: const BoxDecoration(
                      //           // image: DecorationImage(
                      //           //   colorFilter: ColorFilter.mode(ThemeUtils.sameBrightness(context), BlendMode.dstATop),
                      //           //   image: AssetImage('assets/images/products/bg-3.png'),
                      //           //   fit: BoxFit.contain,
                      //           // ),
                      //           ),
                      //       child: Padding(
                      //         padding: EdgeInsets.all(9.h),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             SizedBox(height: 10.h),
                      //             const Text(
                      //               'Are You Sure Want to Logout',
                      //               style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.w600),
                      //             ),
                      //             const SizedBox(height: MySizes.spaceBtwItems),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 ElevatedButton(
                      //                   onPressed: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: Text(
                      //                     'No',
                      //                     style: TextStyle(
                      //                       color: ThemeUtils.sameBrightness(
                      //                           context),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(width: 20),
                      //                 ElevatedButton(
                      //                   style: ElevatedButton.styleFrom(
                      //                       backgroundColor:
                      //                           Colors.red.withOpacity(0.8)),
                      //                   onPressed: () async {},
                      //                   child: const Text('Yes',
                      //                       style: TextStyle(
                      //                         color: Colors.white,
                      //                       )),
                      //                 ),
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
