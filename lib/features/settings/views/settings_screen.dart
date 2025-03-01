// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/settings/view_model/course_provider.dart';
import 'package:student_pal/features/today/views/create_class.dart';
import 'package:student_pal/shared/app_assets.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/custom_widget/courses_listTile.dart';
import 'package:student_pal/shared/custom_widget/custom_switch.dart';
import 'package:student_pal/shared/custom_widget/information_card.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';

import '../../authentication/view_model/authentication_provider.dart';
import '../model/user_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (BuildContext context, AuthenticationProvider authProvider,
          Widget? child) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Settings",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 32.spMin)),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Personal settings',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "Edit >",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                FutureBuilder<UserModel?>(
                  future: authProvider.firebaseService.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.blueColor),
                      ));
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return Center(child: Text("Error loading user data"));
                    }

                    UserModel user = snapshot.data!;

                    return Column(
                      children: [
                        InformationCard(
                            name: user.name ?? "No Name",
                            image: AppAssets.profileIcon),
                        SizedBox(height: 8),
                        Divider(),
                        SizedBox(height: 8),
                        InformationCard(
                            name: user.email ?? "No Email",
                            image: AppAssets.emailIcon),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Classes Settings",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRouter.push(AppRouteStrings.createCourse);
                      },
                      child: Text(
                        "+ course",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Consumer<CourseProvider>(
                  builder: (context, courseProvider, child) {
                    if (courseProvider.courses.isEmpty) {
                      return Center(
                        child: Text("No courses available",
                            style: Theme.of(context).textTheme.displayLarge),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: courseProvider.courses.length,
                      itemBuilder: (context, index) {
                        final course = courseProvider.courses[index];
                        return CourseTile(
                          code: course.code ?? "N/A",
                          courseTitle: course.title ?? "Untitled",
                          color: Color(course.color ?? Colors.grey.value),
                          onEdit: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => CreateClass(
                                        courseTitle: course.title ?? " ",
                                        courseCode: course.code ?? " ",
                                        courseColor: course.color ??
                                            AppColors.actionColor.value,
                                        courseId: course.id ?? 0)));
                          },
                          title: " Add class",
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "App settings",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Divider(),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomSwitch(),
                    TextButton(
                        onPressed: () {
                          authProvider.logout().then((_) =>
                              AppRouter.pushAndClear(
                                  AppRouteStrings.loginScreen));
                        },
                        child: Text(
                          "Logout",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.disclaimerColor),
                        )),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
