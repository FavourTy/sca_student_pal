import 'package:flutter/material.dart';

import '../app_colors.dart';

class ColorPallete extends StatefulWidget {
  const ColorPallete({super.key});

  @override
  State<ColorPallete> createState() => _ColorPalleteState();
}

class _ColorPalleteState extends State<ColorPallete> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(4, (int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: index == 0
                  ? AppColors.blueColor
                  : index == 1
                      ? AppColors.successColor
                      : index == 2
                          ? AppColors.violetColor
                          : AppColors.warningColor,
              child: _selectedIndex == index
                  ? Icon(
                      Icons.done,
                      size: 16,
                    )
                  : Container(),
            ),
          ),
        );
      }),
    );
  }
}
