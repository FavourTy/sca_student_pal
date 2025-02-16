import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_pal/features/assignments/views/classes_lists.dart';
import 'package:student_pal/features/assignments/views/due_date.dart';
import 'package:student_pal/features/assignments/views/priority_screen.dart';
import 'package:student_pal/shared/app_assets.dart';
import 'package:student_pal/shared/app_colors.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assignments",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 32.spMin),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(25.0)),
                child: TabBar(controller: _controller, tabs: [
                  Tab(text: "Due Date"),
                  Tab(text: "Classes"),
                  Tab(text: "Priority")
                ]),
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    children: [DueDate(), ClassesLists(), PriorityScreen()]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.push(AppRouteStrings.createAssignment);
        },
        backgroundColor: AppColors.actionColor,
        child: SvgPicture.asset(AppAssets.addIcon),
      ),
    );
  }
}
