// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sound_notification/firebaseservice.dart';
import 'package:sound_notification/localnotificationservice.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    print(
        "----------------------- initstate of home page -----------------------");
    super.initState();

    FirebaseMessaging.instance.getToken().then((value) {
      textEditingController.text = value!;
      print("Token: $value");
    });

    LocalNotificationService().initialize();
    MyFirebaseService().initialize();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "----------------------- build method of home page -----------------------");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Center(
              child: Text(
            'Home',
            style: TextStyle(fontSize: 40),
          )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              maxLines: 6,
            ),
          ),
        ]));
  }
}
