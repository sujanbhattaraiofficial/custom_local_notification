import 'package:customize_notification/customizedNotification.dart';
import 'package:customize_notification/sharePrefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 7, 00);
    var endTime = DateTime(now.year, now.month, now.day, 22, 00);
    SharedPrefs().setStartTime(startTime.toString());
    SharedPrefs().setEndTime(endTime.toString());
    return MaterialApp(
      home: CustomizedNotification(),
      debugShowCheckedModeBanner: false,
    );
  }
}
