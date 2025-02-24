import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/today/view_models/create_class_provider.dart';
import 'package:student_pal/shared/custom_widget/class_tile.dart';

class ClassesLists extends StatefulWidget {
  const ClassesLists({super.key});

  @override
  State<ClassesLists> createState() => _ClassesListsState();
}

class _ClassesListsState extends State<ClassesLists> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Consumer<CreateClassProvider>(
          builder: (context, classprovider, child) {
            return ListView.builder(
                itemCount: classprovider.classes.length,
                itemBuilder: (context, index) {
                  final classList = classprovider.classes[index];
                  return ClassTile(
                      startTime: classList.startTime ?? " ",
                      endTime: classList.endTime ?? " ",
                      courseCode: classList.note ?? " ",
                      courseTitle: classList.title ?? " ",
                      color: Color(classList.color ?? Colors.grey.value));
                });
          },
        ));
  }
}
