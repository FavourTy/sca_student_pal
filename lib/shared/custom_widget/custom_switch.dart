import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/services/nottification_services.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/theme/theme_provider.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  var notifyHelper = NottificationServices();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Row(
          children: [
            Switch(
              activeColor: AppColors.successColor,
              inactiveThumbColor: AppColors.darkModeContainerColor,
              inactiveTrackColor: Colors.transparent,
              value: themeProvider.isSelected,
              onChanged: (bool value) {
                notifyHelper.displayNotification(
                    title: "Theme changed",
                    body: themeProvider.isSelected
                        ? "Activated Light mode"
                        : "Activated Dark mode");
                themeProvider.toggleTheme();
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              themeProvider.isSelected ? "Dark mode" : "Light mode",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      },
    );
  }
}
