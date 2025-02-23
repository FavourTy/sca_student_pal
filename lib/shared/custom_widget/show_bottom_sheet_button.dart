// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowBottomSheetButton extends StatelessWidget {
  ShowBottomSheetButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.color,
      required this.isclosed});
  final String label;
  final VoidCallback onTap;
  final Color color;
  bool isclosed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 55.h,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: isclosed == true ? Colors.transparent : color,
            border: Border.all(
              width: 2,
              color: isclosed == true ? Colors.grey[600]! : color,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
      ),
    );
  }
}
