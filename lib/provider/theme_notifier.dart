import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:biriyani/utils/themes/dark_theme.dart';
import 'package:biriyani/utils/themes/light_theme.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightTheme) {
    _loadTheme(); // Load theme preference on initialization
  }

  Future<void> toggleTheme() async {
    // Toggle theme
    state = state.brightness == Brightness.dark ? lightTheme : darkTheme;

    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', state.brightness == Brightness.dark);
  }

  Future<void> _loadTheme() async {
    // Load theme preference
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    state = isDarkTheme ? darkTheme : lightTheme;
  }
}

// Provider to access theme state
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
