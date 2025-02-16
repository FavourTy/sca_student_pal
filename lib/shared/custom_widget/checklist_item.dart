import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChecklistItem extends StatelessWidget {
  const ChecklistItem(
      {super.key,
      required this.title,
      required this.note,
      required this.isChecked,
      this.onToggle,
      required this.activeColor});
  final String title;
  final String note;
  final bool isChecked;
  final VoidCallback? onToggle;
  final Color activeColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
                value: isChecked,
                onChanged: (value) => onToggle,
                activeColor: activeColor),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Text(note, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
