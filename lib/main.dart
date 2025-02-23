import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/features/authentication/view_model/authentication_provider.dart';
import 'package:student_pal/features/settings/view_model/course_provider.dart';
import 'package:student_pal/features/today/view_models/create_class_provider.dart';
import 'package:student_pal/repository/create_new_class_repo.dart';
import 'package:student_pal/services/firebase_services.dart';
import 'package:student_pal/services/nottification_services.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';
import 'package:student_pal/shared/theme/theme_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NottificationServices.initializeNotification();
  await CreateNewClassRepo.deleteDataBase();
  await CreateNewClassRepo.initializeDb();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => CreateClassProvider()),
    ChangeNotifierProvider(create: (context) => CourseProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                AuthenticationProvider(firebaseService: firebaseService)),
      ],
      child: ScreenUtilInit(
        designSize: Size(394, 854),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Provider.of<ThemeProvider>(context).themeData,
            onGenerateRoute: AppRouter.appRouter,
            initialRoute: firebaseService.auth.currentUser != null
                ? AppRouteStrings.base
                : AppRouteStrings.loginScreen,
            navigatorKey: AppRouter.navKey,
          );
        },
      ),
    );
  }
}
