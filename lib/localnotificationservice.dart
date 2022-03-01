// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sound_notification/testscreen.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flnp =
      FlutterLocalNotificationsPlugin();

  void initialize() {
    print(
        "----------------------- initializing local notification service -----------------------");

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    void onselectNotification(String? value) {
      print(
          "----------------------- on select notification of flns -----------------------");
      Get.to(() => TestScreen());
    }

    flnp.initialize(initializationSettings,
        onSelectNotification: onselectNotification);
  }

  void display(RemoteMessage message) {
    print(
        "----------------------- diaplaying notification -----------------------");

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
            "1", "Android Local Notification Channel",
            channelDescription:
                "This is the flutter's android local notification channel",
            importance: Importance.max,
            priority: Priority.high,
            enableLights: true,
            timeoutAfter: 10000,
            playSound: true,
            sound: RawResourceAndroidNotificationSound("ringtone1"),
            fullScreenIntent: true);

    try {
      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: const IOSNotificationDetails());

      flnp.show(id, message.notification!.title, message.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      print(
          "----------------------- exception from displaying notification: $e -----------------------");
    }
  }
}
