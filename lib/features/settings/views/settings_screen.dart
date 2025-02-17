import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/app_assets.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/custom_widget/classes_listTile.dart';
import 'package:student_pal/shared/custom_widget/custom_switch.dart';
import 'package:student_pal/shared/custom_widget/information_card.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
            InformationCard(
                name: "Florencia Yanuzzi", image: AppAssets.profileIcon),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            InformationCard(
                name: "florenciayanuzzi@gmail.com", image: AppAssets.emailIcon),
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
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          AppRouter.push(AppRouteStrings.createClass);
                        },
                        child: Icon(Icons.add)),
                    Text(
                      "class",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            CourseTile(
              code: "ENG 204",
              courseTitle: "Engineering Mathematics",
              color: AppColors.violetColor,
              onEdit: () {},
            ),
            Divider(),
            CourseTile(
              code: "MEE 204",
              courseTitle: "ThermoDynamics",
              color: AppColors.violetColor,
              onEdit: () {},
            ),
            Divider(),
            CourseTile(
              code: "MTE 204",
              courseTitle: "Mechatronics Engineering ",
              color: AppColors.blueColor,
              onEdit: () {},
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
            CustomSwitch(),
          ],
        ),
      )),
    );
  }
}
