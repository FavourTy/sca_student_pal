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
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final TextEditingController _courseTitleController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "9:30 PM";
  int _selectedRemind = 5;
  String _selectedRepeat = "None";
  int _selectedIndex = 0;
  final String _courseTitle = "Eg Engineering Mathematics";
  final String _courseCodeHint = "Eg Eng 204";

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
                  title: "Course Title",
                  myHintText: _courseTitle,
                  controller: _courseTitleController),
              SizedBox(
                height: 10.h,
              ),
              InputText(
                  title: "Course Code",
                  myHintText: _courseCodeHint,
                  controller: _courseCodeController),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                title: "Date",
                hintText: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    onPressed: () {
                      _getDateFromUser();
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
                height: 10.h,
              ),
              Text(
                "Color",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              Wrap(
                children: List<Widget>.generate(4, (int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: index == 0
                            ? AppColors.blueColor
                            : index == 1
                                ? AppColors.successColor
                                : index == 2
                                    ? AppColors.violetColor
                                    : AppColors.warningColor,
                        child: _selectedIndex == index
                            ? Icon(
                                Icons.done,
                                size: 16,
                              )
                            : Container(),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(BuildContext context) {
    if (_courseTitleController.text.isNotEmpty &&
        _courseCodeController.text.isNotEmpty) {
      //add to database
      _addClassToDb(context);
      // go back to previous page
      AppRouter.push(AppRouteStrings.todayScreen);
    } else if (_courseTitleController.text.isEmpty ||
        _courseCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "All fields are required",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
  }

  _addClassToDb(BuildContext context) async {
    final createNewClassProvider =
        Provider.of<CreateClassProvider>(context, listen: false);
    int value = await createNewClassProvider.addClass(
        createNewClass: CreateNewClass(
      color: _selectedIndex,
      courseTitle: _courseTitleController.text,
      courseCode: _courseCodeController.text,
      isCompleted: 0,
      repeat: _selectedRepeat,
      remind: _selectedRemind,
      startTime: _startTime,
      endTime: _endTime,
      date: DateFormat.yMd().format(_selectedDate),
    ));
    print("my value is " + "$value");
  }

  _getDateFromUser() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        initialDate: DateTime.now(),
        lastDate: DateTime(2125));
    if (pickDate != null) {
      setState(() {
        _selectedDate = pickDate;
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
}
