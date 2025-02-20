import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../shared/app_colors.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<Map<String, dynamic>> schedule = [
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'timer': 'Now',
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: Column(
          children: [
            // Display Selected Date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("MMMM d, yyyy").format(_selectedDay),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 24.spMin),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table Calendar
            TableCalendar(
              rowHeight: 33.h,
              daysOfWeekHeight: 30.h,
              calendarStyle: CalendarStyle(isTodayHighlighted: false),
              calendarBuilders: CalendarBuilders(
                dowBuilder: (_, d) {
                  return Container(
                    decoration: isSameDay(d, _selectedDay)
                        ? const BoxDecoration(
                            color: AppColors.actionColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                            ))
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            DateFormat("EE").format(d),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: isSameDay(d, _selectedDay)
                                        ? FontWeight.w700
                                        : null),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                selectedBuilder: (_, d, dd) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.actionColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        d.day.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                fontSize: 22.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                },
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerVisible: false,
              firstDay: now,
              lastDay: now.add(const Duration(days: (30 * 6))),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.week,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              // Schedule List
              Expanded(
                child: ListView.builder(
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    var item = schedule[index];
                    return Card(
                      shadowColor: Colors.transparent,
                      color: Theme.of(context).cardColor,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                item['timer'],
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ),
                            ExpansionTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              tilePadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              expandedAlignment: Alignment.topLeft,
                              childrenPadding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item['time'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          )),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item['title'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .warningColor)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '• ${item['room']} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            // Missing Assignment Indicator
                                            if (item['assignments'].any(
                                                (assignment) => !assignment[
                                                    'completed'])) ...[
                                              Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.disclaimerColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  item['assignments']
                                                      .where((assignment) =>
                                                          !assignment[
                                                              'completed'])
                                                      .length
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Text(
                                                ' Missing assignment',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              )
                                            ],
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Assignments',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // Trash Icon
                                        // IconButton(
                                        //   onPressed: () {
                                        //     // Implement delete functionality here
                                        //   },
                                        //   icon: const Icon(Icons.delete,
                                        //       color: Colors.red),
                                        // ),
                                        if (item['assignments'].any(
                                            (assignment) =>
                                                !assignment['completed'])) ...[
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: AppColors.disclaimerColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              item['assignments']
                                                  .where((assignment) =>
                                                      !assignment['completed'])
                                                  .length
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    ...item['assignments']
                                        .map<Widget>((assignment) {
                                      return CheckboxListTile(
                                        activeColor: AppColors.warningColor,
                                        contentPadding: EdgeInsets.only(
                                            left: 100, right: 50),
                                        // contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          assignment['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                fontSize: 16.sp,
                                              ),
                                        ),
                                        value: assignment['completed'],
                                        onChanged: (val) {
                                          setState(() {
                                            assignment['completed'] = val!;
                                          });
                                        },
                                      );
                                    }).toList(),
                                    // Add Assignment Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide(
                                                color: AppColors.actionColor,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Add functionality to add an assignment
                                          },
                                          label: Text(
                                            'Cancel',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        TextButton.icon(
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColors.actionColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Add functionality to add an assignment
                                          },
                                          icon: Icon(
                                            size: 20,
                                            Icons.add,
                                            color: AppColors
                                                .darkModeBackgroundColor,
                                          ),
                                          label: Text(
                                            'Assignment',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors
                                                        .darkModeBackgroundColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
}
