import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/app_assets.dart';

import '../../shared/app_colors.dart';
import '../../shared/custom_widget/onboard_button.dart';
import '../../shared/custom_widget/skip_button.dart';
import '../../shared/navigation/app_route_string.dart';
import '../../shared/navigation/app_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    AppAssets.welcome,
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
                "Welcome to \n Student Pal",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Your",
                  children: [
                    TextSpan(
                      text: " ultimate scheduler",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blueColor,
                              ),
                    ),
                    TextSpan(
                      text:
                          " to stay on top of classes, assignments, and study sessions",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
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
                    text: "Skip",
                    callback: () {
                      AppRouter.pushAndClear(AppRouteStrings.loginScreen);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  OnboardButton(
                    text: "Next",
                    callback: () {
                      AppRouter.pushAndClear(AppRouteStrings.detailsScreen);
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
