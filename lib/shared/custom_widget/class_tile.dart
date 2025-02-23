import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassTile extends StatelessWidget {
  const ClassTile(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.courseCode,
      required this.courseTitle,
      required this.color});

  final String startTime;
  final String endTime;
  final String courseCode;
  final String courseTitle;
  final Color color;

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
                Text("$courseCode - $courseTitle",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            Text("$startTime - $endTime",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700))
          ],
        ),
        Divider(),
      ],
    );
  }
}
