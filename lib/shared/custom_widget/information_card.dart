import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_pal/shared/app_colors.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key, required this.name, required this.image});
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          image,
          color: AppColors.otherLightModeTextColor,
        ),
        SizedBox(
          width: 12.w,
        ),
        Text(name)
      ],
    );
  }
}
