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
      'title': 'MGT 101 - Organization Management',
      'room': 'Room 101',
      'color': Colors.amber,
      'assignments': [
        {'title': 'Checklist title 1', 'completed': true},
        {'title': 'Checklist title 2', 'completed': false},
        {'title': 'Checklist title 3', 'completed': false},
      ]
    },
    {
      'time': '09:10 AM',
      'title': 'EC 203 - Principles Macroeconomics',
      'room': 'Room 213',
      'color': Colors.teal,
      'assignments': []
    },
    {
      'time': '10:10 AM',
      'title': 'EC 202 - Principles Microeconomics',
      'room': 'Room 302',
      'color': Colors.purple,
      'assignments': []
    },
    {
      'time': '11:10 AM',
      'title': 'FN 215 - Financial Management',
      'room': 'Room 111',
      'color': Colors.blue,
      'assignments': []
    }
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
                      color: item['color'],
                      child: ExpansionTile(
                        title: Text(item['title'],
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          '${item['time']} • ${item['room']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        children: item['assignments'].map<Widget>((assignment) {
                          return CheckboxListTile(
                            title: Text(
                              assignment['title'],
                              style: const TextStyle(color: Colors.white),
                            ),
                            value: assignment['completed'],
                            onChanged: (val) {
                              setState(() {
                                assignment['completed'] = val!;
                              });
                            },
                          );
                        }).toList(),
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
