import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/app_assets.dart';

import '../../shared/app_colors.dart';
import '../../shared/navigation/app_route_string.dart';
import '../../shared/navigation/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                child: Image.asset(
                  AppAssets.onboardingBg,
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  callback: () {
                    AppRouter.pushAndClear(AppRouteStrings.loginScreen);
                  },
                  text: "Get Started",
                ),
                SizedBox(
                  height: 10,
                ),
                BackButton(
                  callback: () {
                    AppRouter.pushAndClear(AppRouteStrings.detailsScreen);
                  },
                  text: "Back",
                ),
                const SizedBox(
                  height: 37,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.callback,
  });

  final String text;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: callback,
      child: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(38),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 26.sp,
                      color: AppColors.darkModeContainerColor,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          )),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
    required this.text,
    this.callback,
  });

  final String text;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: callback,
      child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(38),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 23.sp,
                      color: AppColors.darkModeContainerColor,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          )),
    );
  }
}
