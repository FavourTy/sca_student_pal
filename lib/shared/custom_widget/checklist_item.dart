import 'package:flutter/material.dart';

class ChecklistItem extends StatelessWidget {
  const ChecklistItem(
      {super.key,
      required this.title,
      required this.note,
      required this.isChecked,
      this.onToggle});
  final String title;
  final String note;
  final bool isChecked;
  final VoidCallback? onToggle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) => onToggle,
        activeColor: Colors.orange,
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(note, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
