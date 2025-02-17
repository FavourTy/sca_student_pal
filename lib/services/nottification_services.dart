import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NottificationServices {
  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initializeNotification() async {
    tz.initializeTimeZones();
    final AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); //i will add the app icon

    final DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
            requestBadgePermission: false,
            requestAlertPermission: false,
            requestSoundPermission: true);

    final InitializationSettings initSettings = InitializationSettings(
        iOS: iosInitSettings, android: androidInitSettings);
    await localNotificationsPlugin.initialize(
      initSettings,
    );
  }
  //schduledNotification fxn

  scheduledNotification() async {
    await localNotificationsPlugin.zonedSchedule(
      0,
      'scheduled title',
      'theme changes 5 seconds ago',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

//displayNotifications
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        "your channel id", "your channel name",
        channelDescription: "your channel description",
        importance: Importance.max,
        priority: Priority.high,
        ticker: "ticker");
    var iosPlatformChannelSpecifics = new DarwinNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await localNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: "default_Sound");
  }

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

  //fxn to select Notification
  Future selectNoti(String? payload) async {
    if (payload != null) {
      print("notication Payload");
    } else {
      print("Notification done");
    }
    //empty container for now
  }
}
