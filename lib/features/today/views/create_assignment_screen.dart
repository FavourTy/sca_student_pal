import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/constants.dart';
import 'package:student_pal/shared/custom_widget/custom_text_form_field.dart';

class CreateAssignmentScreen extends StatefulWidget {
  const CreateAssignmentScreen({super.key});

  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  bool _ischecked = false;
  DateTime _selectedDueDate = DateTime.now();
  String _defaultRepeatList = "None";
  int _defaultReminder = 5;
  String _selected = "ENG 201 - Engineering Mathematics";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 90,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text(
                      "Cancel",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.actionColor),
                    ),
                  ),
                  Text(
                    "Save",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.actionColor),
                  )
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                CustomTextFormField(
                    title: "Title",
                    hintText: "Eg Read Book",
                    controller: _titleController),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hintText: _selected,
                  title: "Class name",
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
                      items: classesList
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ));
                      }).toList(),
                      onChanged: (String? newvalue) {
                        setState(() {
                          _selected = newvalue!;
                        });
                      }),
                ),
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
}
