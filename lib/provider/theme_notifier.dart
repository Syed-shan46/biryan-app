import 'package:biriyani/utils/themes/dark_theme.dart';
import 'package:biriyani/utils/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightTheme); // Default to light theme

  void toggleTheme() {
    state = state.brightness == Brightness.dark ? lightTheme : darkTheme;
  }
}

// Provider to access theme state
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
