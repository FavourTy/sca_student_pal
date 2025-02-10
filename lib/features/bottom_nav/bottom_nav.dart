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
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: onTapItem,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.todayIcon),
              label: "Today",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.weekIcon),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.checklistIcon),
              label: "Assignments",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppAssets.settingsIcon),
              label: "Settings",
            )
          ]),
    );
  }
}
