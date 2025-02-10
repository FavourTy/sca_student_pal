import 'package:flutter/material.dart';
import 'package:student_pal/shared/custom_widget/custom_class_details.dart';
import 'package:student_pal/shared/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
    );
  }
}
