import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/custom_widget/custom_button.dart';

class CourseTile extends StatelessWidget {
  const CourseTile(
      {super.key,
      required this.code,
      required this.courseTitle,
      required this.color,
      required this.onEdit,
      required this.title});

  final String code;
  final String courseTitle;
  final Color color;
  final VoidCallback onEdit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 3,
                  height: 40,
                  decoration: BoxDecoration(color: color),
                  child: VerticalDivider(
                    width: 2,
                    color: Colors.transparent,
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                  ),
                ),
                SizedBox(width: 8.w),
                Text("$code - $courseTitle",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(
              width: 30.w,
            ),
            SizedBox(
              width: 130,
              child: CustomButton(
                title: title,
                onEdit: onEdit,
              ),
            )
            // GestureDetector(
            //   onTap: onEdit,
            //   child:
            //       Text("Edit >", style: Theme.of(context).textTheme.bodyMedium),
            // )
          ],
        ),
        Divider(),
      ],
    );
  }
}
