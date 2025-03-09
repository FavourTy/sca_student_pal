import 'package:flutter/material.dart';

import '../../shared/app_assets.dart';
import '../../shared/app_colors.dart';
import '../../shared/navigation/app_route_string.dart';
import '../../shared/navigation/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 15),
      () {
        AppRouter.push(AppRouteStrings.welcomeScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
