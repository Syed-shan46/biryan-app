import 'package:biriyani/common/custom_shapes/primary_header_container.dart';
import 'package:biriyani/features/authentication/controllers/auth_controller.dart';
import 'package:biriyani/features/authentication/screens/login/phone_verification_page.dart';
import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/features/shop/screens/notifications/notification_screen.dart';
import 'package:biriyani/features/shop/screens/order/user_orders_screen.dart';
import 'package:biriyani/features/shop/screens/profile/widgets/settings_menu_tile.dart';
import 'package:biriyani/features/shop/screens/profile/widgets/user_profile_tile.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

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
                      Get.snackbar(
                          ' Not Available', "We'll add this feature later 😊",
                          backgroundColor:
                              AppColors.lightBackground.withOpacity(0.6),
                          icon: const Icon(Icons.message_outlined));
                    },
                  ).animate().slideY(
                        begin: 5, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 200),
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

                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.to(() => const CartScreen()),
                  child: const MySettingsMenuTile(
                          icon: Iconsax.shopping_bag,
                          title: 'My Cart',
                          subTitle: 'Add, Remove products and move to checkout')
                      .animate()
                      .slideX(
                        begin: -1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 300),
                      ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const UserOrders());
                  },
                  child: const MySettingsMenuTile(
                          icon: Iconsax.bag_tick,
                          title: 'My Orders',
                          subTitle: 'In-progress and Completed Orders')
                      .animate()
                      .slideX(
                        begin: -1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 400),
                      ),
                ),

                const MySettingsMenuTile(
                  icon: Iconsax.security_card,
                  title: 'Account Privacy',
                  subTitle: 'Manage data usage and connected accounts',
                ).animate().slideX(
                      begin: -1, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                    ),

                MySettingsMenuTile(
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                  icon: Iconsax.notification,
                  title: 'Notifications',
                  subTitle: 'See Your all Notifications',
                ).animate().slideX(
                      begin: -1, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                    ),

                const SizedBox(height: MySizes.spaceBtwItems),
                SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: OutlinedButton(
                      onPressed: () {
                        if (user == null) {
                          // Redirect to Login
                          Get.to(() => const PhoneVerificationPage());
                        } else {
                          // Logout logic

                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 120.h,
                                decoration: const BoxDecoration(
                                    // image: DecorationImage(
                                    //   colorFilter: ColorFilter.mode(ThemeUtils.sameBrightness(context), BlendMode.dstATop),
                                    //   image: AssetImage('assets/images/products/bg-3.png'),
                                    //   fit: BoxFit.contain,
                                    // ),
                                    ),
                                child: Padding(
                                  padding: EdgeInsets.all(9.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10.h),
                                      const Text(
                                        'Are You Sure Want to Logout',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                          height: MySizes.spaceBtwItems),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                color:
                                                    ThemeUtils.sameBrightness(
                                                        context),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red
                                                    .withOpacity(0.8)),
                                            onPressed: () async {
                                              await authController.signOutUser(
                                                context: context,
                                                ref: ref,
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Yes',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                          side: WidgetStateProperty.all(BorderSide(
                              color: user == null
                                  ? AppColors.primaryColor
                                  : Colors.red))),
                      child: Text(
                        user == null ? 'Login' : 'Logout',
                        style: TextStyle(
                            color: user == null
                                ? AppColors.primaryColor
                                : Colors.red),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
