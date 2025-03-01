import 'package:flutter/cupertino.dart';
import 'package:student_pal/features/assignments/views/assignment_screen.dart';
import 'package:student_pal/features/bottom_nav/bottom_nav.dart';
import 'package:student_pal/features/schedule/views/schedule_screen.dart';
import 'package:student_pal/features/settings/views/create_course.dart';
import 'package:student_pal/features/settings/views/settings_screen.dart';
import 'package:student_pal/features/today/views/create_assignment_screen.dart';
import 'package:student_pal/features/today/views/today_screen.dart';

import '../../features/authentication/views/login_screen.dart';
import '../../features/authentication/views/register_screen.dart';
import 'app_route_string.dart';

class AppRouter {
  static final navKey = GlobalKey<NavigatorState>();

  static Route appRouter(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteStrings.base:
        return CupertinoPageRoute(builder: (_) => const CustomButtomNavBar());
      case AppRouteStrings.scheduleScreen:
        return CupertinoPageRoute(builder: (_) => const ScheduleScreen());
      case AppRouteStrings.loginScreen:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case AppRouteStrings.registerScreen:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      case AppRouteStrings.settingsScreen:
        return CupertinoPageRoute(builder: (_) => const SettingsScreen());
      case AppRouteStrings.todayScreen:
        return CupertinoPageRoute(builder: (_) => const TodayScreen());
      case AppRouteStrings.assignmentScreen:
        return CupertinoPageRoute(builder: (_) => const AssignmentScreen());
      // case AppRouteStrings.createAssignment:
      //   return CupertinoPageRoute(
      //       builder: (_) => const CreateAssignmentScreen());
      // case AppRouteStrings.createClass:
      //   return CupertinoPageRoute(builder: (_) => const CreateClass(
      //   ));
      case AppRouteStrings.createCourse:
        return CupertinoPageRoute(builder: (_) => const CreateCourse());
      default:
        return CupertinoPageRoute(builder: (_) => const SizedBox());
    }
  }

  static void push(String name, {Object? arg}) {
    navKey.currentState?.pushNamed(name, arguments: arg);
  }

  static void pushReplace(String name, {Object? arg}) {
    navKey.currentState?.pushReplacementNamed(name, arguments: arg);
  }

  static void pop(String name, {Object? arg}) {
    navKey.currentState?.pop(arg);
  }

  static void pushAndClear(String name, {Object? arg}) {
    navKey.currentState?.pushNamedAndRemoveUntil(name, (_) => false);
  }
}
