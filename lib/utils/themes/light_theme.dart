import 'package:biriyani/utils/themes/app_colors.dart';
import 'package:biriyani/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.accentColor,
    error: AppColors.errorColor,
    surface: AppColors.lightBackground,
    onPrimary: Colors.white, // Text color on primary color
    onSecondary: Colors.white, // Text color on secondary color
    onError: Colors.white,
    onSurface: AppColors.lightTextColor,
  ),
  appBarTheme:  const AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: AppColors.darkBackground),
    titleTextStyle: TextStyle(
      color: AppColors.lightTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: textTheme.apply(bodyColor: AppColors.lightTextColor),
  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    hintStyle: TextStyle(color: Colors.grey[800]),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey[400]!),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.green,
    selectedItemColor: AppColors.primaryColor, // Selected item color
    unselectedItemColor: Colors.grey, // Unselected item color
  ),

  elevatedButtonTheme: const ElevatedButtonThemeData( 
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.darkBackground))
  )
  
);
