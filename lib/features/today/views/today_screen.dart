import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';
import 'package:student_pal/features/today/view_models/create_class_provider.dart';
import 'package:student_pal/features/today/views/create_assignment_screen.dart';
import 'package:student_pal/services/nottification_services.dart';
import 'package:student_pal/shared/custom_widget/custom_button.dart';
import 'package:student_pal/shared/custom_widget/get_assignment_list.dart';
import 'package:student_pal/shared/custom_widget/show_bottom_sheet_button.dart';
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
  var notifyHelper = NottificationServices();
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                child: Consumer<CreateClassProvider>(
                  builder: (context, classProvider, child) {
                    if (classProvider.classes.isEmpty) {
                      return Center(
                          child: Text("Class Schedule is empty",
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return ListView.builder(
                      itemCount: classProvider.classes.length,
                      itemBuilder: (context, index) {
                        CreateNewClass createNewClass =
                            classProvider.classes[index];
                        final timeFormat = DateFormat('hh:mm a');
                        final dateTime = timeFormat
                            .parse(createNewClass.startTime.toString());
                        final hour = dateTime.hour;
                        final minutes = dateTime.minute;
                        notifyHelper.scheduledNotification(
                            hour, minutes, createNewClass);
                        if (createNewClass.repeat == "Daily" ||
                            createNewClass.startDate ==
                                DateFormat.yMd().format(_selectedDay)) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context, createNewClass);
                                    print("Tapped");
                                  },
                                  child: Card(
                                      shadowColor: Colors.transparent,
                                      color: Theme.of(context).cardColor,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Now',
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
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            tilePadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                            expandedCrossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            expandedAlignment:
                                                Alignment.topLeft,
                                            childrenPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                            shape: const RoundedRectangleBorder(
                                              side: BorderSide.none,
                                            ),
                                            title: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      classProvider
                                                              .classes
                                                              .firstOrNull!
                                                              .startTime ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall
                                                          ?.copyWith(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            " ${classProvider.classes.firstOrNull?.note ?? " "} - ${classProvider.classes.firstOrNull?.title ?? " "} ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displayMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        18.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Color(classProvider
                                                                            .classes
                                                                            .firstOrNull
                                                                            ?.color ??
                                                                        Colors
                                                                            .grey
                                                                            .value))),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    '• Room 101',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displaySmall
                                                                        ?.copyWith(
                                                                          fontSize:
                                                                              14.sp,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(6),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: AppColors
                                                                          .disclaimerColor,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                  )
                                                                ]),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Text(
                                                              'Assignments',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            GetAssignmentList(),
                                                            SizedBox(
                                                              height: 15.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextButton
                                                                          .icon(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              AppColors.actionColor,
                                                                          width:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    label: Text(
                                                                      'Cancel',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .displayMedium
                                                                          ?.copyWith(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                CustomButton(
                                                                    title:
                                                                        "Assignment",
                                                                    onEdit: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          CupertinoPageRoute(
                                                                              builder: (_) => CreateAssignmentScreen(courseColor: classProvider.classes.firstOrNull?.color ?? 0, courseCode: classProvider.classes.firstOrNull!.note ?? ' ', classId: classProvider.classes.firstOrNull!.id ?? 0, courseName: classProvider.classes.firstOrNull!.title ?? ' ')));
                                                                    })
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          )
                                        ]),
                                      )),
                                ),
                              ),
                            ),
                          );
                        }
                      },
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

  _showBottomSheet(BuildContext context, CreateNewClass createClass) {
    final ClassProvider =
        Provider.of<CreateClassProvider>(context, listen: false);
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Theme.of(context).cardColor,
            height: createClass.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.24
                : MediaQuery.of(context).size.height * 0.24,
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightModeContainerColor),
                ),
                Spacer(),
                createClass.isCompleted == 1
                    ? Container()
                    : ShowBottomSheetButton(
                        isclosed: false,
                        label: "Class completed",
                        onTap: () {
                          ClassProvider.markClassCompleted(createClass.id!);
                          Navigator.pop(context);
                        },
                        color: AppColors.actionColor),
                ShowBottomSheetButton(
                    isclosed: false,
                    label: "Delete Class",
                    onTap: () {
                      ClassProvider.deleteClass(createClass.id!);
                      Navigator.pop(context);
                      //delete Class from provider
                    },
                    color: AppColors.deleteColor),
                ShowBottomSheetButton(
                    isclosed: true,
                    label: "Close",
                    onTap: () {},
                    color: Theme.of(context).scaffoldBackgroundColor),
              ],
            ),
          );
        });
  }
}
