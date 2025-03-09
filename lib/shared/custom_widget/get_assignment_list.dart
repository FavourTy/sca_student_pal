import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/assignments/view_model/assignment_provider.dart';

// class GetAssignmentList extends StatefulWidget {
//   const GetAssignmentList({super.key, required this.classId});

//   final int classId;

//   @override
//   State<GetAssignmentList> createState() => _GetAssignmentListState();
// }

// class _GetAssignmentListState extends State<GetAssignmentList> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AssignmentProvider>(
//       builder: (context, assProvider, child) {
//         // Filter assignments by classId
//         final classAssignments = assProvider.assignments
//             .where((assignment) => assignment.classId == widget.classId)
//             .toList();

//         if (classAssignments.isEmpty) {
//           return Center(
//               child: Text("No assignments available",
//                   style: Theme.of(context).textTheme.bodyMedium));
//         }

//         return ListView.builder(
//             itemCount: classAssignments.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               final assignment = classAssignments[index];
//               return Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                               value: assignment.isCompleted == 1,
//                               onChanged: (value) {
//                                 assProvider
//                                     .markClassCompleted(assignment.id ?? 0);
//                               },
//                               activeColor: Color(
//                                   assignment.courseColor ?? Colors.grey.value)),
//                           Text(assignment.title ?? "N/A",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .copyWith(
//                                       decoration: assignment.isCompleted == 1
//                                           ? TextDecoration.lineThrough
//                                           : TextDecoration.none)),
//                         ],
//                       ),
//                       assignment.isCompleted == 1
//                           ? IconButton(
//                               onPressed: () {
//                                 assProvider
//                                     .deleteAssignment(assignment.id ?? 0);
//                               },
//                               icon: Icon(Icons.delete))
//                           : SizedBox()
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   )
//                 ],
//               );
//             });
//       },
//     );
//   }
// }
//
// class GetAssignmentList extends StatefulWidget {
//   const GetAssignmentList({super.key, required this.classId});
//
//   final int classId;
//
//   @override
//   State<GetAssignmentList> createState() => _GetAssignmentListState();
// }
//
// class _GetAssignmentListState extends State<GetAssignmentList> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AssignmentProvider>(
//       builder: (context, assProvider, child) {
//         // final classAssignments = assProvider.assignments
//         //     .where((assignment) => assignment.classId == widget.classId)
//         //     .toList();
//         final classAssignments = assProvider.assignments
//             .where((assignment) => assignment.classId == widget.classId)
//             .toList();
//
//         if (classAssignments.isEmpty) {
//           return Center(
//             child: Text(
//               "No assignments available",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           );
//         }
//
//         return SizedBox(
//           height: classAssignments.length * 60.0, // Adjust height dynamically
//           child: ListView.builder(
//             itemCount: classAssignments.length,
//             shrinkWrap: true,
//             // Ensures it only takes necessary space
//             physics: NeverScrollableScrollPhysics(),
//             // Prevents scrolling conflicts
//             itemBuilder: (context, index) {
//               final assignment = classAssignments[index];
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: assignment.isCompleted == 1,
//                             onChanged: (value) {
//                               assProvider
//                                   .markClassCompleted(assignment.id ?? 0);
//                             },
//                             activeColor: Color(
//                                 assignment.courseColor ?? Colors.grey.value),
//                           ),
//                           Text(
//                             assignment.title ?? "N/A",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                   decoration: assignment.isCompleted == 1
//                                       ? TextDecoration.lineThrough
//                                       : TextDecoration.none,
//                                 ),
//                           ),
//                         ],
//                       ),
//                       assignment.isCompleted == 1
//                           ? IconButton(
//                               onPressed: () {
//                                 assProvider
//                                     .deleteAssignment(assignment.id ?? 0);
//                               },
//                               icon: Icon(Icons.delete),
//                             )
//                           : SizedBox()
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class GetAssignmentList extends StatelessWidget {
  const GetAssignmentList({super.key, required this.classId});

  final int classId;

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentProvider>(
      builder: (context, assProvider, child) {
        // Filter assignments by classId
        final classAssignments = assProvider.assignments
            .where((assignment) => assignment.classId == classId)
            .toList();

        if (classAssignments.isEmpty) {
          return Center(
            child: Text(
              "No assignments available",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        // Use a ListView to display assignments
        return ListView.builder(
          shrinkWrap: true, // Ensure the ListView fits inside the Column
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          itemCount: classAssignments.length,
          itemBuilder: (context, index) {
            final assignment = classAssignments[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                              assignment.courseColor ?? Colors.grey.value),
                        ),
                        Text(
                          assignment.title ?? "N/A",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    decoration: assignment.isCompleted == 1
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                        ),
                      ],
                    ),
                    assignment.isCompleted == 1
                        ? IconButton(
                            onPressed: () {
                              assProvider.deleteAssignment(assignment.id ?? 0);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}
