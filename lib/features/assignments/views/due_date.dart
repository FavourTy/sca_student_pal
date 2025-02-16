import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/custom_widget/assignment_card.dart';

class DueDate extends StatefulWidget {
  const DueDate({super.key});

  @override
  State<DueDate> createState() => _DueDateState();
}

class _DueDateState extends State<DueDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today - Feburary 24th, 2025",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 10.h),
            AssignmentCard(
                courseCode: "ENG 204",
                courseTitle: 'Engineering Mathematics',
                color: AppColors.warningColor,
                checklistItems: [
                  {
                    'title': 'checklist title 1',
                    'note': 'Note from checklist 1',
                    'checked': true,
                    'color': AppColors.warningColor
                  },
                  {
                    'title': 'checklist title 2',
                    'note': 'Note from checklist 2',
                    'checked': true,
                    'color': AppColors.warningColor
                  },
                  {
                    'title': 'checklist title 3',
                    'note': 'Note from checklist 3',
                    'checked': false,
                    'color': AppColors.warningColor
                  },
                ]),
            AssignmentCard(
                courseCode: "MEE 206",
                courseTitle: 'Thermodynamics',
                color: AppColors.violetColor,
                checklistItems: [
                  {
                    'title': 'checklist title 1',
                    'note': 'Note from checklist 1',
                    'checked': true,
                    'color': AppColors.violetColor
                  },
                  {
                    'title': 'checklist title 2',
                    'note': 'Note from checklist 2',
                    'checked': false,
                    'color': AppColors.violetColor
                  },
                ])
          ],
        ),
      ),
    ));
  }
}
