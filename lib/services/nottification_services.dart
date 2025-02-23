// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:student_pal/features/today/models/create_class_model.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NottificationServices {
//   static FlutterLocalNotificationsPlugin localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future initializeNotification() async {
//     _configureLocalTimeZone();
//     tz.initializeTimeZones();
//     final AndroidInitializationSettings androidInitSettings =
//         AndroidInitializationSettings(
//             '@mipmap/ic_launcher'); //i will add the app icon

//     final DarwinInitializationSettings iosInitSettings =
//         DarwinInitializationSettings(
//             requestBadgePermission: false,
//             requestAlertPermission: false,
//             requestSoundPermission: true);

//     final InitializationSettings initSettings = InitializationSettings(
//         iOS: iosInitSettings, android: androidInitSettings);
//     await localNotificationsPlugin.initialize(
//       initSettings,
//     );
//   }
//   //schduledNotification fxn

//   scheduledNotification(
//       int hour, int minutes, CreateNewClass createnewClass) async {
//     await localNotificationsPlugin.zonedSchedule(
//         createnewClass.id!,
//         createnewClass.title,
//         'Your class is about to start',
//         _convertTime(hour, minutes),
//         //  tz.TZDateTime.now(tz.local).add(Duration(seconds: newTime)),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 'your channel id', 'your channel name',
//                 channelDescription: 'your channel description')),
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         matchDateTimeComponents: DateTimeComponents.time);
//   }

//   tz.TZDateTime _convertTime(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduleDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
//     if (scheduleDate.isBefore(now)) {
//       scheduleDate = scheduleDate.add(Duration(days: 1));
//     }
//     return scheduleDate;
//   }

//   static Future<void> _configureLocalTimeZone() async {
//     final String timeZone = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZone));
//     // tz.getLocation(timeZone);
//   }

// //displayNotifications
//   displayNotification({required String title, required String body}) async {
//     print("doing test");
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         "your channel id", "your channel name",
//         channelDescription: "your channel description",
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: "ticker");
//     var iosPlatformChannelSpecifics = new DarwinNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iosPlatformChannelSpecifics);
//     await localNotificationsPlugin.show(
//         0, title, body, platformChannelSpecifics,
//         payload: "default_Sound");
//   }

//   void requestIosPermissions() {
//     localNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }

//   //fxn to select Notification
//   Future selectNoti(String? payload) async {
//     if (payload != null) {
//       print("notication Payload");
//     } else {
//       print("Notification done");
//     }
//     //empty container for now
//   }
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:student_pal/features/today/models/create_class_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NottificationServices {
  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initializeNotification() async {
    // Ensure timezone is configured
    tz.initializeTimeZones();
    await _configureLocalTimeZone();

    final AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
            requestBadgePermission: true,
            requestAlertPermission: true,
            requestSoundPermission: true);

    final InitializationSettings initSettings = InitializationSettings(
        android: androidInitSettings, iOS: iosInitSettings);

    await localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap
      },
    );
  }

  // Scheduled Notification Function
  Future<void> scheduledNotification(
      int hour, int minutes, CreateNewClass createnewClass) async {
    try {
      await localNotificationsPlugin.zonedSchedule(
        createnewClass.id!,
        createnewClass.title,
        'Your class is about to start',
        _convertTime(hour, minutes),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            channelDescription: 'your_channel_description',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      print(
          'Notification scheduled for ${createnewClass.title} at $hour:$minutes');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  // Convert Time to TZDateTime
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    // If the scheduled time is in the past, add one day
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  // Configure Local Timezone
  static Future<void> _configureLocalTimeZone() async {
    try {
      final String timeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZone));
      print('Timezone configured: $timeZone');
    } catch (e) {
      print('Error configuring timezone: $e');
    }
  }

  // Display Notification
  Future<void> displayNotification(
      {required String title, required String body}) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.high,
        priority: Priority.high,
      );

      const DarwinNotificationDetails iosPlatformChannelSpecifics =
          DarwinNotificationDetails(
        sound: 'default.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics,
      );

      await localNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: 'default_sound',
      );
      print('Notification displayed: $title');
    } catch (e) {
      print('Error displaying notification: $e');
    }
  }

  // Request iOS Permissions
  void requestIosPermissions() {
    localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // Handle Notification Tap
  Future<void> selectNoti(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    } else {
      print('Notification tapped without payload');
    }
  }
}
