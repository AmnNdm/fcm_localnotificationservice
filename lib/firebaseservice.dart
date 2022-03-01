// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sound_notification/localnotificationservice.dart';
import 'package:sound_notification/testscreen.dart';

class MyFirebaseService {
  void initialize() {
    print(
        "----------------------- initializing my firebase service -----------------------");

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      print(
          "----------------------- in FirebaseMessaging.instance.getInitialMessage()  -----------------------");
      print("message: $message");
      if (message != null) {
        print(
            "----------------------- in FirebaseMessaging.instance.getInitialMessage() if message != null -----------------------");
        Get.to(() => TestScreen());
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      print(
          "----------------------- in FirebaseMessaging.onMessage -----------------------");
      Get.to(() => TestScreen());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(
          "----------------------- in FirebaseMessaging.onMessageOpenedApp -----------------------");
      Get.to(() => TestScreen());
    });
  }
}

Future backgroundHandler(RemoteMessage message) async {
  print(
      "----------------------- in backgroundHandler() -----------------------");
  print("message: $message");
  LocalNotificationService().display(message);
}
