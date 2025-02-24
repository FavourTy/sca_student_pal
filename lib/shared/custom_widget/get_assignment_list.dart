import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/assignments/view_model/assignment_provider.dart';

class GetAssignmentList extends StatefulWidget {
  const GetAssignmentList({super.key});

  @override
  State<GetAssignmentList> createState() => _GetAssignmentListState();
}

class _GetAssignmentListState extends State<GetAssignmentList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentProvider>(
      builder: (context, assProvider, child) {
        if (assProvider.assignments.isEmpty) {
          return Center(
              child: Text("No assignments available",
                  style: Theme.of(context).textTheme.bodyMedium));
        }
        final firstAssignment = assProvider.assignments.first;
        return ListView.builder(
            itemCount: assProvider.assignments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final assignment = assProvider.assignments[index];
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
                          activeColor: Color(firstAssignment.courseColor ??
                              Colors.grey.value)),
                      Text(firstAssignment.title ?? "N/A",
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
