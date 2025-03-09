import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({super.key, required this.text, this.callback});

  final String text;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: callback,
        child: Container(
          height: 60,
          width: 130,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.blueColor, width: 2.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueColor),
              )
            ],
          ),
        ));
  }
}
