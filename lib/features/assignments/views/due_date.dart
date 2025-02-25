import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/assignments/view_model/assignment_provider.dart';
import 'package:student_pal/shared/custom_widget/checklist_item.dart';

// class DueDate extends StatefulWidget {
//   const DueDate({super.key});
//   @override
//   State<DueDate> createState() => _DueDateState();
// }

// class _DueDateState extends State<DueDate> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<AssignmentProvider>(
//         builder: (context, assignmentProvider, child) {
//           if (assignmentProvider.assignments.isEmpty) {
//             return Center(
//                 child: Text("No assignments available",
//                     style: Theme.of(context).textTheme.bodyMedium));
//           }
//           final firstAssignment = assignmentProvider.assignments.first;

//           final selectedDueDate = firstAssignment.dueDate;
//           String heading = "Today, ${_formatDate(DateTime.now())}";
//           final now = DateTime.now();

//           if (selectedDueDate != null) {
//             try {
//               final selectedDueDateString = parseCustomDate(selectedDueDate);
//               if (_isSameDay(selectedDueDateString, now)) {
//                 heading = "Today, ${_formatDate(selectedDueDateString)}";
//               } else if (_isSameDay(
//                   selectedDueDateString, now.add(Duration(days: 1)))) {
//                 heading = "Tomorrow, ${_formatDate(selectedDueDateString)}";
//               } else {
//                 heading = _formatDate(selectedDueDateString);
//               }
//             } catch (e) {
//               print("Invalid date format: $selectedDueDate");
//               heading = "Invalid date";
//             }
//           }
//           return ListView.builder(
//             itemCount: assignmentProvider.assignments.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               final assignment = assignmentProvider.assignments[index];
//               return ChecklistItem(
//                 assignment: assignment,
//                 title: assignment.title ?? "N/A",
//                 note: assignment.description ?? "N/A",
//                 activeColor: Color(assignment.courseColor ?? Colors.grey.value),
//                 courseCode: assignment.courseCode ?? "N/A",
//                 courseTitle: assignment.courseName ?? "N/A",
//                 color: Color(assignment.courseColor ?? Colors.grey.value),
//                 heading: heading,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     return "${_getMonthName(date.month)} ${date.day}, ${date.year}";
//   }

//   String _getMonthName(int month) {
//     switch (month) {
//       case 1:
//         return 'Jan';
//       case 2:
//         return 'Feb';
//       case 3:
//         return 'Mar';
//       case 4:
//         return 'Apr';
//       case 5:
//         return 'May';
//       case 6:
//         return 'Jun';
//       case 7:
//         return 'Jul';
//       case 8:
//         return 'Aug';
//       case 9:
//         return 'Sep';
//       case 10:
//         return 'Oct';
//       case 11:
//         return 'Nov';
//       case 12:
//         return 'Dec';
//       default:
//         return '';
//     }
//   }

//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }

//   DateTime parseCustomDate(String dateString) {
//     final parts = dateString.split('/');
//     if (parts.length != 3) {
//       throw FormatException("Invalid date format: $dateString");
//     }
//     final month = int.parse(parts[0]);
//     final day = int.parse(parts[1]);
//     final year = int.parse(parts[2]);
//     return DateTime(year, month, day);
//   }
// }

class DueDate extends StatefulWidget {
  const DueDate({super.key});
  @override
  State<DueDate> createState() => _DueDateState();
}

class _DueDateState extends State<DueDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AssignmentProvider>(
        builder: (context, assignmentProvider, child) {
          if (assignmentProvider.assignments.isEmpty) {
            return Center(
                child: Text("No assignments available",
                    style: Theme.of(context).textTheme.bodyMedium));
          }

          return ListView.builder(
            itemCount: assignmentProvider.assignments.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final assignment = assignmentProvider.assignments[index];
              final selectedDueDate = assignment.dueDate;
              String heading = "Today, ${_formatDate(DateTime.now())}";
              final now = DateTime.now();

              if (selectedDueDate != null) {
                try {
                  final selectedDueDateString =
                      parseCustomDate(selectedDueDate);
                  if (_isSameDay(selectedDueDateString, now)) {
                    heading = "Today, ${_formatDate(selectedDueDateString)}";
                  } else if (_isSameDay(
                      selectedDueDateString, now.add(Duration(days: 1)))) {
                    heading = "Tomorrow, ${_formatDate(selectedDueDateString)}";
                  } else {
                    heading = _formatDate(selectedDueDateString);
                  }
                } catch (e) {
                  print("Invalid date format: $selectedDueDate");
                  heading = "Invalid date";
                }
              }

              return ChecklistItem(
                assignment: assignment,
                title: assignment.title ?? "N/A",
                note: assignment.description ?? "N/A",
                activeColor: Color(assignment.courseColor ?? Colors.grey.value),
                courseCode: assignment.courseCode ?? "N/A",
                courseTitle: assignment.courseName ?? "N/A",
                color: Color(assignment.courseColor ?? Colors.grey.value),
                heading: heading,
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${_getMonthName(date.month)} ${date.day}, ${date.year}";
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  DateTime parseCustomDate(String dateString) {
    final parts = dateString.split('/');
    if (parts.length != 3) {
      throw FormatException("Invalid date format: $dateString");
    }
    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}
