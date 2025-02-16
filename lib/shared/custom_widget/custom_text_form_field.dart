import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/theme/theme_provider.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.controller,
      this.widget,
      required this.title});
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 5,
        ),
        Consumer<ThemeProvider>(
          builder: (context, themeprovider, child) {
            return TextFormField(
              style: themeprovider.isSelected
                  ? TextStyle(
                      //darkmode
                      fontSize: 14.spMin,
                      fontFamily: "Inter",
                      color: AppColors.lightModeContainerColor,
                      fontWeight: FontWeight.w400)
                  : TextStyle(
                      fontSize: 14.spMin,
                      fontFamily: "Inter",
                      color: AppColors.otherLightModeTextColor,
                      fontWeight: FontWeight.w400
                      //darkmode
                      ),
              autofocus: false,
              readOnly: widget == null ? false : true,
              controller: controller,
              decoration: InputDecoration(
                  hintText: hintText,
                  suffixIcon: widget == null
                      ? Container()
                      : Container(
                          child: widget,
                        )),
            );
          },
        ),
      ],
    );
  }
}
