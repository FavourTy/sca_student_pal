import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_pal/services/nottification_services.dart';
import 'package:student_pal/shared/navigation/app_route_string.dart';
import 'package:student_pal/shared/navigation/app_router.dart';
import 'package:student_pal/shared/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NottificationServices.initializeNotification();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(394, 854),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context).themeData,
          onGenerateRoute: AppRouter.appRouter,
          initialRoute: AppRouteStrings.base,
          navigatorKey: AppRouter.navKey,
        );
      },
    );
  }
}
