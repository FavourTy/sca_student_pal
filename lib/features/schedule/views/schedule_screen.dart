import 'package:calendar_view/calendar_view.dart' as calendar_view;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../shared/app_colors.dart';

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

  void _addEvents() {
    _eventController.add(calendar_view.CalendarEventData(
        title: "Macro",
        startTime: DateTime(2025, 2, 19, 10, 0),
        endTime: DateTime(2025, 2, 19, 12, 0),
        date: DateTime(2025, 2, 19)));
    _eventController.add(calendar_view.CalendarEventData(
        title: "Macro",
        startTime: DateTime(2025, 2, 18, 10, 0),
        endTime: DateTime(2025, 2, 18, 13, 0),
        date: DateTime(2025, 2, 18)));
    _eventController.add(calendar_view.CalendarEventData(
        title: "Macro",
        startTime: DateTime(2025, 2, 20, 8, 0),
        endTime: DateTime(2025, 2, 20, 12, 0),
        date: DateTime(2025, 2, 20)));
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
                  eventTileBuilder: (date, events, boundary, start, end) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      child: Container(
                          width: 64.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColors.violetColor,
                          ),
                          child: Center(child: Text(events.first.title))),
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
