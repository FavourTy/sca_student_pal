import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/assignments/model/assignment_model.dart';
import 'package:student_pal/features/assignments/view_model/assignment_provider.dart';
import 'package:student_pal/shared/app_assets.dart';

class ChecklistItem extends StatelessWidget {
  const ChecklistItem({
    super.key,
    this.onEdit,
    required this.title,
    required this.note,
    required this.activeColor,
    required this.courseCode,
    required this.courseTitle,
    required this.color,
    required this.heading,
    required this.assignment,
  });
  final String title;
  final String note;
  final Color activeColor;
  final String courseCode;
  final String courseTitle;
  final Color color;
  final VoidCallback? onEdit;
  final String heading;
  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssignmentProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15.h,
        ),
        Text(
          heading,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$courseCode - $courseTitle',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: color)),
            GestureDetector(
                onTap: onEdit,
                child: SvgPicture.asset(
                  AppAssets.editIcon,
                  color: color,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                    value: assignment.isCompleted == 1,
                    onChanged: (value) {
                      provider.markClassCompleted(assignment.id ?? 0);
                    },
                    activeColor: activeColor),
                Text(title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: assignment.isCompleted == 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              ],
            ),
            assignment.isCompleted == 1
                ? IconButton(
                    onPressed: () {
                      provider.deleteAssignment(assignment.id ?? 0);
                    },
                    icon: Icon(Icons.delete))
                : SizedBox()
          ],
        ),
        Text(note, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
