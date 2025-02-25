import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';
import 'package:student_pal/features/today/view_models/create_class_provider.dart';
import 'package:student_pal/shared/constants.dart';
import 'package:student_pal/shared/custom_widget/input_text.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/custom_widget/custom_text_form_field.dart';

class CreateClass extends StatefulWidget {
  final String courseTitle;
  final String courseCode;
  final int courseColor;
  final int courseId;
  const CreateClass(
      {super.key,
      required this.courseTitle,
      required this.courseCode,
      required this.courseColor,
      required this.courseId});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  String _selectedRepeat = "None";
  List<String> _selectedRecurrenceDays = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          title: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.pop(AppRouteStrings.settingsScreen);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.actionColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _validateDate(context);
                  },
                  child: Text(
                    "Save",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.actionColor),
                  ),
                )
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Class",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 20.h,
              ),
              InputText(
                readOnly: true,
                title: "Course Title",
                myHintText: widget.courseTitle,
              ),
              SizedBox(
                height: 10.h,
              ),
              InputText(
                title: "Course Code",
                myHintText: widget.courseCode,
                readOnly: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                title: " start Date",
                hintText: DateFormat.yMd().format(_selectedStartDate),
                widget: IconButton(
                    onPressed: () {
                      _getStartDateFromUser();
                    },
                    icon: Icon(Icons.calendar_today_outlined)),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                title: "End Date",
                hintText: DateFormat.yMd().format(_selectedEndDate),
                widget: IconButton(
                    onPressed: () {
                      _getEndDateFromUser();
                    },
                    icon: Icon(Icons.calendar_today_outlined)),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(children: [
                Expanded(
                    child: CustomTextFormField(
                  hintText: _startTime,
                  title: "Start Time",
                  widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: Icon(Icons.access_time_rounded)),
                )),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                    child: CustomTextFormField(
                  hintText: _endTime,
                  title: "End Time",
                  widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: Icon(Icons.access_time_rounded)),
                )),
              ]),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: "$_selectedRemind minutes early",
                title: "Remind",
                widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(
                      height: 0.h,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: _selectedRepeat,
                title: "Repeat",
                widget: DropdownButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    iconSize: 32,
                    elevation: 4,
                    underline: Container(
                      height: 0.h,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    items: remindRepeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                  hintText: _selectedRecurrenceDays.isNotEmpty
                      ? _selectedRecurrenceDays.join(", ")
                      : " Select days",
                  title: "Reccurence",
                  widget: IconButton(
                      onPressed: () {
                        _showRecurrenceSelector(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_down))),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Color",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              CircleAvatar(
                  radius: 14, backgroundColor: Color(widget.courseColor)),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(BuildContext context) {
    _addClassToDb(context);
    // go back to previous page
    AppRouter.pushReplace(AppRouteStrings.base);
  }

  _addClassToDb(BuildContext context) async {
    final createNewClassProvider =
        Provider.of<CreateClassProvider>(context, listen: false);
    int value = await createNewClassProvider.addClass(
        createNewClass: CreateNewClass(
            courseId: widget.courseId,
            title: widget.courseTitle,
            note: widget.courseCode,
            recurrence: _selectedRecurrenceDays,
            isCompleted: 0,
            repeat: _selectedRepeat,
            remind: _selectedRemind,
            startTime: _startTime,
            endTime: _endTime,
            startDate: DateFormat.yMd().format(_selectedStartDate),
            endDate: DateFormat.yMd().format(_selectedEndDate),
            color: widget.courseColor));
    print("my value is " + "$value");
  }

  _getStartDateFromUser() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        initialDate: DateTime.now(),
        lastDate: DateTime(2125));
    if (pickDate != null) {
      setState(() {
        _selectedStartDate = pickDate;
      });
    }
  }

  _getEndDateFromUser() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        initialDate: DateTime.now(),
        lastDate: DateTime(2125));
    if (pickDate != null) {
      setState(() {
        _selectedEndDate = pickDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var isPickedTime = await _showTimePicker();
    String formattedTime = isPickedTime.format(context);
    if (isPickedTime == null) {
      print("ime canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  //recurrence selector

  _showRecurrenceSelector(BuildContext context) async {
    final List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    final selectedDays = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            "Select Recurrence Days",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16.sp),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: weekdays.map((day) {
                return CheckboxListTile(
                  activeColor: AppColors.actionColor,
                  title: Text(
                    day,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: _selectedRecurrenceDays.contains(day),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedRecurrenceDays.add(day);
                      } else {
                        _selectedRecurrenceDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.deleteColor)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child:
                  Text("Save", style: Theme.of(context).textTheme.bodyMedium),
              onPressed: () {
                Navigator.of(context).pop(_selectedRecurrenceDays);
              },
            )
          ],
        );
      },
    );

    if (selectedDays != null) {
      setState(() {
        _selectedRecurrenceDays = selectedDays;
      });
    }
  }
}
