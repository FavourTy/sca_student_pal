import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTile extends StatelessWidget {
  const CourseTile(
      {super.key,
      required this.code,
      required this.courseTitle,
      required this.color,
      this.onEdit});
  final String code;
  final String courseTitle;
  final Color color;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Container(
        height: double.infinity,
        width: 4.w,
        color: color,
      ),
      title: Text("$code - $courseTitle",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w700)),
      trailing: GestureDetector(
        onTap: onEdit,
        child: Text("Edit >", style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
