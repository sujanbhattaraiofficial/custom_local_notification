import 'package:customize_notification/customizedNotification.dart';
import 'package:customize_notification/sharePrefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    var startTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 00);
    setStartTime(startTime);
    var endTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 00);
    setEndTime(endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomizedNotification();
            }));
          },
          child: Container(
              height: 60,
              width: 100,
              child: Icon(
                Icons.alarm,
                size: 50,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
