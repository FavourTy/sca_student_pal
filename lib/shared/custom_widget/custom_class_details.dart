import 'package:flutter/material.dart';
import 'package:student_pal/shared/app_colors.dart';

class CustomClassDetails extends StatefulWidget {
  const CustomClassDetails({super.key, required this.onTheme});
  final VoidCallback onTheme;

  @override
  State<CustomClassDetails> createState() => _CustomClassDetailsState();
}

class _CustomClassDetailsState extends State<CustomClassDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
