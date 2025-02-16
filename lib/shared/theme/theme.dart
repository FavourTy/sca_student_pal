import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    //iconTheme
    iconTheme: IconThemeData(color: AppColors.lightModeTextColor),
    //tab bar theme
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent, // Remove the divider between tabs
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: AppColors.actionColor),
      labelStyle: TextStyle(
          fontSize: 14.spMin,
          color: AppColors.lightModeTextColor,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(
          fontSize: 14.spMin,
          color: AppColors.lightModeTextColor,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
    ),
    //app bar theme
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppColors.lightModeContainerColor),
    //text theme
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
    //bottom Appbar Theme
    bottomAppBarTheme:
        BottomAppBarTheme(color: AppColors.lightModeContainerColor),
    // scaffold background color
    scaffoldBackgroundColor: AppColors.lightModeBackgroundColor,
    // input decoration theme : for textform field
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
    ),
    //checkbox theme
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.lightModeBackgroundColor),
      fillColor: WidgetStatePropertyAll(AppColors.lightModeBackgroundColor),
    ),
    // divider theme
    dividerColor: AppColors.lightModeTextColor,
    // card Color: to be used as the container background color
    cardColor: AppColors.lightModeContainerColor,
    //bottom nav bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: AppColors.lightModeContainerColor,
        selectedItemColor: AppColors.blueColor,
        selectedIconTheme: IconThemeData(
          color: AppColors.blueColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.otherLightModeTextColor,
        ),
        selectedLabelStyle: TextStyle(
            // color: AppColors.blueColor,
            fontSize: 12.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400),
        unselectedItemColor: AppColors.otherLightModeTextColor,
        unselectedLabelStyle: TextStyle(
            // color: AppColors.otherLightModeTextColor,
            fontSize: 12.spMin,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400)),
    //snackBarTheme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.lightModeContainerColor,
    ),
    //dropdownMenuTheme
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(AppColors.lightModeContainerColor))),
  );

  static final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    //iconTheme
    iconTheme: IconThemeData(color: AppColors.darkModeheadingTextColor),
    //tab bar theme
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.actionColor,
      ),
      labelStyle: TextStyle(
          fontSize: 14.spMin,
          color: AppColors.lightModeTextColor,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(
          fontSize: 14.spMin,
          color: AppColors.darkModeheadingTextColor,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700),
    ),
    //app bar theme
    appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppColors.darkModeContainerColor),
    //divider theme
    dividerColor: AppColors.lightModeContainerColor,
    //text theme
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
    //bottom nav bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: AppColors.darkModeContainerColor,
      selectedItemColor: const Color.fromRGBO(83, 110, 255, 1),
      selectedIconTheme: IconThemeData(
        color: AppColors.blueColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.otherLightModeTextColor,
      ),
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
          fontWeight: FontWeight.w400),
    ),
    //bottom appBar theme
    bottomAppBarTheme:
        BottomAppBarTheme(color: AppColors.darkModeContainerColor),
    //scaffold theme
    scaffoldBackgroundColor: AppColors.darkModeBackgroundColor,
    // card Color: to be used as the container background color
    cardColor: AppColors.darkModeContainerColor,
    // input decoration theme : for textform field
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
    ),
    //checkbox theme
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.darkModeBackgroundColor),
      fillColor: WidgetStatePropertyAll(AppColors.darkModeBackgroundColor),
    ),
    //snackBarTheme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkModeContainerColor,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(AppColors.darkModeContainerColor))),
  );
}
