import 'package:biriyani/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:biriyani/firebase_options.dart';
import 'package:biriyani/navigation_menu.dart';
import 'package:biriyani/provider/user_provider.dart';
import 'package:biriyani/utils/themes/dark_theme.dart';
import 'package:biriyani/utils/themes/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ensure the app initializes properly

    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: FutureBuilder(
            future: _checkTokenAndSetUser(ref),
            builder: (context, snapshot) {
              final user = ref.watch(userProvider);
              return user != null
                  ? const NavigationMenu()
                  : const OnboardingScreen();
            }),
      ),
    );
  }
}
