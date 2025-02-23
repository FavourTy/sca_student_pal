import 'package:flutter/material.dart';

import '../../../shared/app_colors.dart';
import '../../../shared/custom_widget/courses_listTile.dart';

class PriorityScreen extends StatefulWidget {
  const PriorityScreen({super.key});

  @override
  State<PriorityScreen> createState() => _PriorityScreenState();
}

class _PriorityScreenState extends State<PriorityScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView(
        children: [],
      ),
    );
  }
}
