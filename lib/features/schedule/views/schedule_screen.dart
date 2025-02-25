import 'package:calendar_view/calendar_view.dart' as calendar_view;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../today/view_models/create_class_provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? _selectedDate;
  final calendar_view.EventController _eventController =
      calendar_view.EventController();

  @override
  void initState() {
    _selectedDate = DateTime.now();
    _addEvents();
    super.initState();
  }
  // void _addEvents() {
  //   final createClassProvider =
  //       Provider.of<CreateClassProvider>(context, listen: false);
  //   for (var classItem in createClassProvider.classes) {
  //     DateTime startDate =
  //         DateFormat.yMd().parse(classItem.startDate.toString());
  //     DateTime endDate = DateFormat.yMd().parse(classItem.endDate.toString());
  //     final timeFormat = DateFormat('hh:mm a');
  //     DateTime startTime = timeFormat.parse(classItem.startTime.toString());
  //     DateTime endTime = timeFormat.parse(classItem.endTime.toString());

  //     // Combine date and time for the initial event
  //     DateTime eventStart = DateTime(
  //       startDate.year,
  //       startDate.month,
  //       startDate.day,
  //       startTime.hour,
  //       startTime.minute,
  //     );
  //     DateTime eventEnd = DateTime(
  //       startDate.year,
  //       startDate.month,
  //       startDate.day,
  //       endTime.hour,
  //       endTime.minute,
  //     );

  //     // Add the initial event
  //     _eventController.add(calendar_view.CalendarEventData(
  //       title: classItem.title!,
  //       startTime: eventStart,
  //       endTime: eventEnd,
  //       date: startDate,
  //     ));

  //     // Handle recurrence based on the selected days
  //     if (classItem.recurrence.isNotEmpty) {
  //       List<String> recurrenceDays = classItem.recurrence;
  //       // Map weekdays to their corresponding DateTime.weekday values
  //       Map<String, int> weekdayMap = {
  //         "Monday": 1,
  //         "Tuesday": 2,
  //         "Wednesday": 3,
  //         "Thursday": 4,
  //         "Friday": 5,
  //         "Saturday": 6,
  //         "Sunday": 7,
  //       };

  //       // Iterate through each selected recurrence day
  //       for (var day in recurrenceDays) {
  //         int targetWeekday = weekdayMap[day]!;

  //         // Find the next occurrence of the target weekday
  //         DateTime currentDate = startDate.add(Duration(days: 1));
  //         while (currentDate.isBefore(endDate) ||
  //             currentDate.isAtSameMomentAs(endDate)) {
  //           if (currentDate.weekday == targetWeekday) {
  //             DateTime recurringStart = DateTime(
  //               currentDate.year,
  //               currentDate.month,
  //               currentDate.day,
  //               startTime.hour,
  //               startTime.minute,
  //             );
  //             DateTime recurringEnd = DateTime(
  //               currentDate.year,
  //               currentDate.month,
  //               currentDate.day,
  //               endTime.hour,
  //               endTime.minute,
  //             );

  //             // Add the recurring event
  //             _eventController.add(calendar_view.CalendarEventData(
  //               title: classItem.title!,
  //               startTime: recurringStart,
  //               endTime: recurringEnd,
  //               date: currentDate,
  //             ));
  //           }

  //           // Move to the next day
  //           currentDate = currentDate.add(Duration(days: 1));
  //         }
  //       }
  //     }
  //   }
  // }

  void _addEvents() {
    final createClassProvider =
        Provider.of<CreateClassProvider>(context, listen: false);
    for (var classItem in createClassProvider.classes) {
      DateTime startDate =
          DateFormat.yMd().parse(classItem.startDate.toString());
      DateTime endDate = DateFormat.yMd().parse(classItem.endDate.toString());
      final timeFormat = DateFormat('hh:mm a');
      DateTime startTime = timeFormat.parse(classItem.startTime.toString());
      DateTime endTime = timeFormat.parse(classItem.endTime.toString());

      // Combine date and time for the initial event
      DateTime eventStart = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      );
      DateTime eventEnd = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        endTime.hour,
        endTime.minute,
      );

      // Add the initial event with classId
      _eventController.add(calendar_view.CalendarEventData(
        title: classItem.title!,
        startTime: eventStart,
        endTime: eventEnd,
        date: startDate,
        event: classItem.id, // Add classId to the event
      ));

      // Handle recurrence based on the selected days
      if (classItem.recurrence.isNotEmpty) {
        List<String> recurrenceDays = classItem.recurrence;
        // Map weekdays to their corresponding DateTime.weekday values
        Map<String, int> weekdayMap = {
          "Monday": 1,
          "Tuesday": 2,
          "Wednesday": 3,
          "Thursday": 4,
          "Friday": 5,
          "Saturday": 6,
          "Sunday": 7,
        };

        // Iterate through each selected recurrence day
        for (var day in recurrenceDays) {
          int targetWeekday = weekdayMap[day]!;

          // Find the next occurrence of the target weekday
          DateTime currentDate = startDate.add(Duration(days: 1));
          while (currentDate.isBefore(endDate) ||
              currentDate.isAtSameMomentAs(endDate)) {
            if (currentDate.weekday == targetWeekday) {
              DateTime recurringStart = DateTime(
                currentDate.year,
                currentDate.month,
                currentDate.day,
                startTime.hour,
                startTime.minute,
              );
              DateTime recurringEnd = DateTime(
                currentDate.year,
                currentDate.month,
                currentDate.day,
                endTime.hour,
                endTime.minute,
              );

              // Add the recurring event with classId
              _eventController.add(calendar_view.CalendarEventData(
                title: classItem.title!,
                startTime: recurringStart,
                endTime: recurringEnd,
                date: currentDate,
                event: classItem.id, // Add classId to the event
              ));
            }

            // Move to the next day
            currentDate = currentDate.add(Duration(days: 1));
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Schedule",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 32.spMin)),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: calendar_view.WeekView(
                  weekNumberBuilder: (firstDayOfWeek) {
                    return Container();
                  },
                  weekPageHeaderBuilder: calendar_view.WeekHeader.hidden,
                  weekTitleHeight: 72,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  headerStyle: calendar_view.HeaderStyle(
                      leftIconVisible: false,
                      rightIconVisible: false,
                      decoration: BoxDecoration(color: Colors.transparent)),
                  headerStringBuilder: (date, {secondaryDate}) => " ",
                  controller: _eventController,
                  showVerticalLines: false,
                  showWeekends: true,
                  weekDayBuilder: (date) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedDate != null &&
                                    isSameDay(_selectedDate!, date)
                                ? Theme.of(context).cardColor
                                : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  top: 25,
                                ),
                                child: Text(
                                  "${date.day}",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 10, bottom: 5),
                                child: Text(
                                  _getDaysOfWeek(date.weekday),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  // eventTileBuilder: (date, events, boundary, start, end) {
                  //   return Padding(
                  //     padding: const EdgeInsets.only(right: 2, left: 2),
                  //     child: Consumer<CreateClassProvider>(
                  //       builder: (context, classProvider, child) {
                  //         final classItem = classProvider.classes.firstOrNull;
                  //         return Container(
                  //             width: 64.w,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(8.0),
                  //                 color: Color(
                  //                     classItem!.color ?? Colors.grey.value)),
                  //             child: Center(child: Text(events.first.title)));
                  //       },
                  //     ),
                  //   );
                  // },

                  eventTileBuilder: (date, events, boundary, start, end) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      child: Consumer<CreateClassProvider>(
                        builder: (context, classProvider, child) {
                          // Get the classId from the event
                          final classId = events.first.event as int?;
                          // Find the corresponding class
                          final classItem = classProvider.classes.firstWhere(
                            (c) => c.id == classId,
                            orElse: () => CreateNewClass(
                              id: -1,
                              title: "Unknown",
                              color: Colors.grey.value,
                            ), // Fallback if class not found
                          );
                          return Container(
                            width: 64.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color:
                                  Color(classItem.color ?? Colors.grey.value),
                            ),
                            child: Center(
                              child: Text(events.first.title),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDaysOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "";
    }
  }
}
