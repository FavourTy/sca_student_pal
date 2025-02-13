import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_pal/shared/app_assets.dart';

import 'checklist_item.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard(
      {super.key,
      required this.courseCode,
      required this.courseTitle,
      required this.color,
      required this.checklistItems,
      this.onEdit});
  final String courseCode;
  final String courseTitle;
  final Color color;
  final List<Map<String, dynamic>> checklistItems;
  final VoidCallback? onEdit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('$courseCode - $courseCode',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w700, color: color)),
          trailing: GestureDetector(
              onTap: onEdit,
              child: SvgPicture.asset(
                AppAssets.editIcon,
                color: color,
              )),
        ),
        ...checklistItems.map((item) => ChecklistItem(
              title: item['title'],
              note: item['note'],
              isChecked: item['checked'],
              activeColor: item['color'],
            )),
      ],
    );
  }
}
