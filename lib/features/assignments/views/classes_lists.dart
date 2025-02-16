import 'package:flutter/material.dart';
import 'package:student_pal/shared/custom_widget/classes_listTile.dart';

import '../../../shared/app_colors.dart';

class ClassesLists extends StatefulWidget {
  const ClassesLists({super.key});

  @override
  State<ClassesLists> createState() => _ClassesListsState();
}

class _ClassesListsState extends State<ClassesLists> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView(
        children: [
          CourseTile(
              code: "ENG 205",
              courseTitle: "Engineeering Mathematics",
              color: AppColors.warningColor),
          Divider(),
          CourseTile(
              code: "ENG 205",
              courseTitle: "Engineeering Mathematics",
              color: AppColors.warningColor),
          Divider(),
          CourseTile(
              code: "ENG 205",
              courseTitle: "Engineeering Mathematics",
              color: AppColors.violetColor),
          Divider(),
          CourseTile(
              code: "ENG 205",
              courseTitle: "Engineeering Mathematics",
              color: AppColors.successColor),
          Divider(),
          CourseTile(
              code: "ENG 205",
              courseTitle: "Engineeering Mathematics",
              color: AppColors.blueColor),
          Divider(),
        ],
      ),
    );
  }
}
