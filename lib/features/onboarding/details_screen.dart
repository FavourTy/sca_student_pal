import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/app_assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/custom_widget/onboard_button.dart';
import '../../shared/custom_widget/skip_button.dart';
import '../../shared/navigation/app_route_string.dart';
import '../../shared/navigation/app_router.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70.0),
                  child: Image.asset(
                    AppAssets.details,
                    height: 330,
                    width: 330,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                " Take Your Academics to the Next Level",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "Stay organized with smart scheduling, task management, and "
                      "progress tracking. Get reminders for deadlines, classes, and exams—",
                  children: [
                    TextSpan(
                      text: "all in one place!",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blueColor,
                              ),
                    ),
                  ],
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkipButton(
                    text: "Back",
                    callback: () {
                      AppRouter.pushAndClear(AppRouteStrings.welcomeScreen);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  OnboardButton(
                    text: "Next",
                    callback: () {
                      AppRouter.pushAndClear(AppRouteStrings.onboardingScreen);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
