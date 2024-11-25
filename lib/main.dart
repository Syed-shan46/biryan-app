import 'package:biriyani/screens/home/home_screen.dart';
import 'package:biriyani/screens/onboarding/onboarding_screen.dart';
import 'package:biriyani/utils/animation/page_transition.dart';
import 'package:biriyani/utils/themes/dark_theme.dart';
import 'package:biriyani/utils/themes/light_theme.dart';
import 'package:flutter/material.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: OnboardingScreen(),
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          'home' =>
            NoAnimationTransition(builder: (context) => const HomeScreen()),
          _ => NoAnimationTransition(builder: (context) => const HomeScreen())
        };
      },
    );
  }
}
