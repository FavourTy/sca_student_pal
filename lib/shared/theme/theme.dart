import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        elevation: 0, backgroundColor: AppColors.lightModeContainerColor),
    useMaterial3: true,
    textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColors.lightModeTextColor,
            fontSize: 20.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700),
        bodySmall: TextStyle(
            color: AppColors.lightModeTextColor,
            fontSize: 12.spMin,
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: AppColors.lightModeTextColor,
            fontSize: 14.spMin,
            fontWeight: FontWeight.w400)),
    bottomAppBarTheme:
        BottomAppBarTheme(color: AppColors.lightModeContainerColor),
    scaffoldBackgroundColor: AppColors.lightModeBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.lightModeBackgroundColor,
        filled: true,
        hintStyle: TextStyle(
            fontSize: 14.spMin,
            fontFamily: "Inter",
            color: AppColors.otherLightModeTextColor,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.otherLightModeTextColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.otherLightModeTextColor),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.otherLightModeTextColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.otherLightModeTextColor)),
        suffixIconColor: AppColors.otherLightModeTextColor),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.lightModeBackgroundColor),
    ),
    dividerColor: AppColors.lightModeTextColor,
    cardColor: AppColors.lightModeContainerColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightModeContainerColor,
        selectedItemColor: AppColors.blueColor,
        selectedLabelStyle: TextStyle(
            color: AppColors.blueColor,
            fontSize: 12.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400),
        unselectedItemColor: AppColors.otherLightModeTextColor,
        unselectedLabelStyle: TextStyle(
            color: AppColors.otherLightModeTextColor,
            fontSize: 12.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400)),
  );

  static final ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(
        elevation: 0, backgroundColor: AppColors.darkModeContainerColor),
    brightness: Brightness.dark,
    useMaterial3: true,
    dividerColor: AppColors.lightModeContainerColor,
    textTheme: TextTheme(
        displayLarge: TextStyle(
            color: AppColors.darkModeheadingTextColor,
            fontSize: 20.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700),
        bodySmall: TextStyle(
            color: AppColors.darkModeheadingTextColor,
            fontSize: 12.spMin,
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: AppColors.darkModeheadingTextColor,
            fontSize: 14.spMin,
            fontWeight: FontWeight.w400)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkModeContainerColor,
        selectedItemColor: AppColors.blueColor,
        selectedLabelStyle: TextStyle(
            color: AppColors.blueColor,
            fontSize: 12.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400),
        unselectedItemColor: AppColors.navbarTextColor,
        unselectedLabelStyle: TextStyle(
            color: AppColors.navbarTextColor,
            fontSize: 12.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400)),
    bottomAppBarTheme:
        BottomAppBarTheme(color: AppColors.darkModeContainerColor),
    scaffoldBackgroundColor: AppColors.darkModeBackgroundColor,
    cardColor: AppColors.darkModeContainerColor,
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.darkModeBackgroundColor,
        filled: true,
        hintStyle: TextStyle(
            fontSize: 14.spMin,
            fontFamily: "Inter",
            color: AppColors.lightModeContainerColor,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.lightModeContainerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.lightModeContainerColor),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.lightModeContainerColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.lightModeContainerColor)),
        suffixIconColor: AppColors.otherLightModeTextColor),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.darkModeBackgroundColor),
    ),
  );
}
