import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/assignments/view_model/assignment_provider.dart';

class GetAssignmentList extends StatefulWidget {
  const GetAssignmentList({super.key, required this.classId});

  final int classId;

  @override
  State<GetAssignmentList> createState() => _GetAssignmentListState();
}

class _GetAssignmentListState extends State<GetAssignmentList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentProvider>(
      builder: (context, assProvider, child) {
        // Filter assignments by classId
        final classAssignments = assProvider.assignments
            .where((assignment) => assignment.classId == widget.classId)
            .toList();

        if (classAssignments.isEmpty) {
          return Center(
              child: Text("No assignments available",
                  style: Theme.of(context).textTheme.bodyMedium));
        }

        return ListView.builder(
            itemCount: classAssignments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final assignment = classAssignments[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: assignment.isCompleted == 1,
                          onChanged: (value) {
                            assProvider.markClassCompleted(assignment.id ?? 0);
                          },
                          activeColor: Color(
                              assignment.courseColor ?? Colors.grey.value)),
                      Text(assignment.title ?? "N/A",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  decoration: assignment.isCompleted == 1
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none)),
                    ],
                  ),
                  assignment.isCompleted == 1
                      ? IconButton(
                          onPressed: () {
                            assProvider.deleteAssignment(assignment.id ?? 0);
                          },
                          icon: Icon(Icons.delete))
                      : SizedBox()
                ],
              );
            });
      },
    );
  }
}
