// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/settings/model/course_model.dart';
import 'package:student_pal/features/settings/view_model/course_provider.dart';
import 'package:student_pal/shared/navigation/app_router.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/custom_widget/input_text.dart';
import '../../../shared/navigation/app_route_string.dart';

class CreateCourse extends StatefulWidget {
  const CreateCourse({super.key});

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final String _courseTitle = "Eg Engineering Mathematics";
  final String _courseCodeHint = "Eg Eng 204";
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          title: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.pop(AppRouteStrings.settingsScreen);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.actionColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _validateInput(context);
                  },
                  child: Text(
                    "Save",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.actionColor),
                  ),
                )
              ],
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Course",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: 20.h,
            ),
            InputText(
                title: "Course Title",
                myHintText: _courseTitle,
                controller: _courseTitleController),
            SizedBox(
              height: 10.h,
            ),
            InputText(
                title: "Course Code",
                myHintText: _courseCodeHint,
                controller: _courseCodeController),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Color",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 10.h,
            ),
            Wrap(
              children: List<Widget>.generate(4, (int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0
                          ? AppColors.blueColor
                          : index == 1
                              ? AppColors.successColor
                              : index == 2
                                  ? AppColors.violetColor
                                  : AppColors.warningColor,
                      child: _selectedIndex == index
                          ? Icon(
                              Icons.done,
                              size: 16,
                            )
                          : Container(),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  _validateInput(BuildContext context) {
    if (_courseTitleController.text.isNotEmpty &&
        _courseCodeController.text.isNotEmpty) {
      AppRouter.pop(AppRouteStrings.settingsScreen);
      _addCourseToDB(context);
    } else if (_courseTitleController.text.isEmpty ||
        _courseCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "All fields are required",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
  }

  _addCourseToDB(BuildContext context) async {
    final CreateNewCourseProvider =
        Provider.of<CourseProvider>(context, listen: false);
    int value = await CreateNewCourseProvider.addCourse(
        course: CourseModel(
      title: _courseTitleController.text,
      code: _courseCodeController.text,
      color: getColorFromIndex(_selectedIndex),
    ));
    print("my value is" + "$value");
  }

  int getColorFromIndex(int index) {
    switch (index) {
      case 0:
        return AppColors.blueColor.value; // Convert color to integer
      case 1:
        return AppColors.successColor.value;
      case 2:
        return AppColors.violetColor.value;
      case 3:
        return AppColors.warningColor.value;
      default:
        return Colors.grey.value; // Fallback color
    }
  }
}
