import 'package:biriyani/common/custom_shapes/primary_header_container.dart';
import 'package:biriyani/features/authentication/controllers/auth_controller.dart';
import 'package:biriyani/features/authentication/screens/login/phone_verification_page.dart';
import 'package:biriyani/features/shop/screens/cart/cart_screen.dart';
import 'package:biriyani/features/shop/screens/notifications/notification_screen.dart';
import 'package:biriyani/features/shop/screens/order/user_orders_screen.dart';
import 'package:biriyani/features/shop/screens/profile/widgets/settings_menu_tile.dart';
import 'package:biriyani/features/shop/screens/profile/widgets/user_profile_tile.dart';
import 'package:biriyani/features/shop/screens/wishlist/wish_list_screen.dart';
import 'package:biriyani/provider/theme_notifier.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/constants/sizes.dart';
import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/theme_utils.dart';
import 'package:flutter/cupertino.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = ref.watch(userProvider);
    final currentTheme = ref.watch(themeProvider); // Watch the current theme
    final themeNotifier = ref.read(themeProvider.notifier); // Access notifier

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          MyPrimaryHeaderContainer(
              showContainer: false,
              color: ThemeUtils.dynamicTextColor(context),
              child: const UserProfileTile()),
          const SizedBox(
            height: MySizes.spaceBtwItems,
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
                  child: MySettingsMenuTile(
                    trailing: Icon(Icons.chevron_right,
                            color: ThemeUtils.dynamicTextColor(context))
                        .animate()
                        .slideX(
                          begin: -1, // Start below the screen
                          end: 0, // End at normal position
                          curve: Curves.easeInOut,
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 500),
                        ),
                    icon: Iconsax.shopping_bag,
                    title: 'My Cart Items',
                  ).animate().slideY(
                        begin: 1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 500),
                      ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),
                InkWell(
                  onTap: () {
                    Get.to(() => const UserOrders());
                  },
                  child: MySettingsMenuTile(
                    trailing: Icon(Icons.chevron_right,
                            color: ThemeUtils.dynamicTextColor(context))
                        .animate()
                        .slideX(
                          begin: -1, // Start below the screen
                          end: 0, // End at normal position
                          curve: Curves.easeInOut,
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 500),
                        ),
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                  ).animate().slideY(
                        begin: 1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                      ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),

                MySettingsMenuTile(
                  trailing: Icon(Icons.chevron_right,
                          color: ThemeUtils.dynamicTextColor(context))
                      .animate()
                      .slideX(
                        begin: -1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                      ),
                  onTap: () {
                    Get.to(() => const WishListScreen());
                  },
                  icon: Iconsax.heart_circle,
                  title: 'Wishlist',
                ).animate().slideY(
                      begin: 1, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 500),
                    ),
                const SizedBox(height: MySizes.spaceBtwItems),
                MySettingsMenuTile(
                  trailing: Icon(Icons.chevron_right,
                          color: ThemeUtils.dynamicTextColor(context))
                      .animate()
                      .slideX(
                        begin: -1, // Start below the screen
                        end: 0, // End at normal position
                        curve: Curves.easeInOut,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                      ),
                  onTap: () {
                    Get.to(() => const NotificationScreen());
                  },
                  icon: Iconsax.notification,
                  title: 'Notifications',
                ).animate().slideY(
                      begin: 1, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                    ),
                const SizedBox(height: MySizes.spaceBtwItems),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.brightness_6,
                      color:
                          ThemeUtils.dynamicTextColor(context).withOpacity(0.8),
                    ), // You can use any icon you like
                    title: Text(
                      'Theme',
                      style: TextStyle(
                          color: ThemeUtils.dynamicTextColor(context)),
                    ),
                    trailing: Switch(
                      value: currentTheme.brightness ==
                          Brightness.dark, // Check if current theme is dark
                      onChanged: (bool value) {
                        // Toggle the theme when switch is toggled
                        themeNotifier.toggleTheme();
                      },
                    ).animate().slideX(
                          begin: -1, // Start below the screen
                          end: 0, // End at normal position
                          curve: Curves.easeInOut,
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 500),
                        ),
                  ),
                ).animate().slideY(
                      begin: 1, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                    ),
                const SizedBox(height: MySizes.spaceBtwItems),
                MySettingsMenuTile(
                  isRed: true,
                  onTap: () {
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10.h),
                                  const Text(
                                    'Are You Sure Want to Logout',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: MySizes.spaceBtwItems),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color: ThemeUtils.sameBrightness(
                                                context),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.withOpacity(0.8)),
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
                  icon: user == null ? Icons.login : Icons.logout,
                  // child: Text(
                  //       user == null ? 'Login' : 'Logout',
                  //       style: TextStyle(
                  //           color: user == null
                  //               ? AppColors.primaryColor
                  //               : Colors.red),
                  //     ),
                  title: user == null ? 'Login' : 'Log out',
                ).animate().slideY(
                      begin: 1, // Start below the screen
                      end: 0, // End at normal position
                      curve: Curves.easeInOut,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                    ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
