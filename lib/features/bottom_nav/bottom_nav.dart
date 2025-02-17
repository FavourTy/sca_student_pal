import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_pal/features/assignments/views/assignment_screen.dart';
import 'package:student_pal/features/schedule/views/schedule_screen.dart';
import 'package:student_pal/features/settings/views/settings_screen.dart';
import 'package:student_pal/features/today/views/today_screen.dart';

import '../../shared/app_assets.dart';

class CustomButtomNavBar extends StatefulWidget {
  const CustomButtomNavBar({super.key});

  @override
  State<CustomButtomNavBar> createState() => _CustomButtomNavBarState();
}

class _CustomButtomNavBarState extends State<CustomButtomNavBar> {
  // void initState() {
  //   super.initState();
  //   notifyHelper = NottificationServices();
  //   notifyHelper.requestIosPermissions();
  // }

  // var notifyHelper;

  int _selectedIndex = 0;
  void onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = [
    TodayScreen(),
    ScheduleScreen(),
    AssignmentScreen(),
    SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final bottomNavBarTheme = Theme.of(context).bottomNavigationBarTheme;
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: onTapItem,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 24,
                width: 24,
                AppAssets.todayIcon,
                color: _selectedIndex == 0
                    ? bottomNavBarTheme.selectedItemColor
                    : bottomNavBarTheme.unselectedItemColor,
              ),
              label: "Today",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 22,
                width: 22,
                AppAssets.weekIcon,
                color: _selectedIndex == 1
                    ? bottomNavBarTheme.selectedItemColor
                    : bottomNavBarTheme.unselectedItemColor,
              ),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 24,
                width: 24,
                AppAssets.checklistIcon,
                color: _selectedIndex == 2
                    ? bottomNavBarTheme.selectedItemColor
                    : bottomNavBarTheme.unselectedItemColor,
              ),
              label: "Assignments",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                height: 24,
                width: 24,
                AppAssets.settingsIcon,
                color: _selectedIndex == 3
                    ? bottomNavBarTheme.selectedItemColor
                    : bottomNavBarTheme.unselectedItemColor,
              ),
              label: "Settings",
            )
          ]),
    );
  }
}
