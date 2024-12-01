import 'package:biriyani/features/shop/screens/home/product_detail/product_detail_screen.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/features/authentication/onboarding/onboarding_screen.dart';
import 'package:biriyani/utils/animation/page_transition.dart';
import 'package:biriyani/utils/themes/dark_theme.dart';
import 'package:biriyani/utils/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const OnboardingScreen(),
        onGenerateRoute: (settings) {
          // Route handling
          switch (settings.name) {
            case 'home':
              return NoAnimationTransition(
                builder: (context) => const NavigationMenu(),
              );
            case 'product_details':
              // Retrieve arguments if passed (like product data)

              return NoAnimationTransition(
                builder: (context) => const ProductDetailScreen(),
              );
            default:
              return NoAnimationTransition(
                builder: (context) => const NavigationMenu(),
              );
          }
        },
      ),
    );
  }
}
