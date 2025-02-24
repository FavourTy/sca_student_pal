import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/assignments/model/assignment_model.dart';
import 'package:student_pal/features/assignments/view_model/assignment_provider.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/constants.dart';
import 'package:student_pal/shared/custom_widget/custom_text_form_field.dart';
import 'package:student_pal/shared/custom_widget/input_text.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';

class CreateAssignmentScreen extends StatefulWidget {
  final int classId;
  final int courseColor;
  final String courseName;
  final String courseCode;
  const CreateAssignmentScreen(
      {super.key,
      required this.classId,
      required this.courseColor,
      required this.courseName,
      required this.courseCode});

  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  bool _ischecked = false;
  final String _titleHint = "Eg Read Book";
  DateTime _selectedDueDate = DateTime.now();
  String _reminderTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _defaultRepeatList = "None";
  int _defaultReminder = 5;
  DateTime _selectedRemindDate = DateTime.now();

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
                    AppRouter.pop(AppRouteStrings.assignmentScreen);
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
                    _validateInfo(context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Assignment",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 20.h,
              ),
              InputText(
                  title: "Title",
                  myHintText: _titleHint,
                  controller: _titleController),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Details",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                controller: _detailsController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Eg. Read from 100 to 150",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: DateFormat.yMd().format(_selectedDueDate),
                title: "Due Date",
                widget: IconButton(
                    onPressed: () {
                      _getDueDateFromUser();
                    },
                    icon: Icon(Icons.calendar_today_outlined)),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: DateFormat.yMd().format(_selectedRemindDate),
                title: "Reminder Date",
                widget: IconButton(
                    onPressed: () {
                      _getReminderDateFromUser();
                    },
                    icon: Icon(Icons.calendar_today_outlined)),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: _reminderTime,
                title: "Reminder Time",
                widget: IconButton(
                    onPressed: () {
                      _getRemindTimeFromUser(isRemindTime: true);
                    },
                    icon: Icon(Icons.access_time_rounded)),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: "$_defaultReminder minutes early",
                title: "Alert",
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
                          ));
                    }).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        _defaultReminder = int.parse(newvalue!);
                      });
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField(
                hintText: _defaultRepeatList,
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
                        _defaultRepeatList = newValue!;
                      });
                    }),
              ),
              Row(
                children: [
                  Checkbox(value: _ischecked, onChanged: (value) {}),
                  Text(
                    "Set as priority",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _getDueDateFromUser() async {
    DateTime? _isPicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2125));
    if (_isPicked != null) {
      setState(() {
        _selectedDueDate = _isPicked;
      });
    }
  }

  _getReminderDateFromUser() async {
    DateTime? _isPicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2125));
    if (_isPicked != null) {
      setState(() {
        _selectedRemindDate = _isPicked;
      });
    }
  }

  _getRemindTimeFromUser({required bool isRemindTime}) async {
    var isPickedTime = await _showTimePicker();
    String formattedTime = isPickedTime.format(context);
    if (isPickedTime == null) {
      print("ime canceled");
    } else if (isRemindTime == true) {
      setState(() {
        _reminderTime = formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_reminderTime.split(":")[0]),
            minute: int.parse(_reminderTime.split(":")[1].split(" ")[0])));
  }

  _validateInfo(BuildContext context) {
    if (_titleController.text.isNotEmpty &&
        _detailsController.text.isNotEmpty) {
      _addAssignmentToDb(context);
      AppRouter.push(AppRouteStrings.base);
      print("successful");
    } else if (_titleController.text.isEmpty ||
        _detailsController.text.isEmpty) {
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

  _addAssignmentToDb(BuildContext context) async {
    final assignmentProvider =
        Provider.of<AssignmentProvider>(context, listen: false);
    int value = await assignmentProvider.addAssignment(
        assignmentModel: AssignmentModel(
            classId: widget.classId,
            title: _titleController.text,
            dueDate: DateFormat.yMd().format(_selectedDueDate),
            remind: _defaultReminder,
            description: _detailsController.text,
            reminderDate: DateFormat.yMd().format(_selectedRemindDate),
            reminderTime: _reminderTime,
            priority: 0,
            isCompleted: 0,
            notificationId: 0,
            courseCode: widget.courseCode,
            courseColor: widget.courseColor,
            courseName: widget.courseName));
    print("my value is " + "$value");
  }
}
