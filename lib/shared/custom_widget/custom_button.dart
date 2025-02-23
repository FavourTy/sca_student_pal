import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, required this.onEdit});
  final String title;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.actionColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onEdit,
      icon: Icon(
        size: 20,
        Icons.add,
        color: AppColors.darkModeBackgroundColor,
      ),
      label: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.darkModeBackgroundColor),
      ),
    );
  }
}
