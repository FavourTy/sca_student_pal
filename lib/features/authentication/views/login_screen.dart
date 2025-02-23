import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_pal/shared/custom_widget/auth_button.dart';
import 'package:student_pal/shared/custom_widget/auth_text_input.dart';

import '../../../shared/app_colors.dart';
import '../../../shared/constants.dart';
import '../../../shared/navigation/app_route_string.dart';
import '../../../shared/navigation/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Student Pal",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueColor),
                      ),
                      Text(
                        "Login",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthTextInput(
                  controller: emailController,
                  label: "Email",
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z@._-]'))
                  ],
                  validator: (a) {
                    if (!emailRegex.hasMatch(a ?? "")) {
                      return "Inavlid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthTextInput(
                  controller: passwordController,
                  label: "Password",
                  inputFormatter: [
                    FilteringTextInputFormatter.deny(RegExp(r' '))
                  ],
                  validator: (a) =>
                      (a ?? '').isNotEmpty ? null : "Invalid password",
                ),
                const SizedBox(
                  height: 50,
                ),
                if (loading)
                  Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.blueColor),
                    ),
                  )
                else
                  AuthButton(
                    text: "Login",
                    action: () async {},
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppRouter.pushReplace(
                                  AppRouteStrings.registerScreen);
                            },
                          text: " Register",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blueColor),
                        )
                      ],
                      text: "Don't have an account?",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
