import 'dart:async';
import 'package:customize_notification/sharePrefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  static BuildContext context;

  NotificationHelper() {
    initializedNotification();
  }

  initializedNotification() async {
    initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    // do Something here
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    // Navigator.of(context, rootNavigator: true).pop();
                    // await Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Home()));
                  },
                )
              ],
            ));
  }

  Future<void> showNotificationBetweenInterval() async {
    try {
      notificationCompare();
      var now = DateTime.now();
      var currentTime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);

      SharedPreferences.getInstance().then((value) async {
        var a = value.getString('startTime');
        var b = value.getString('endTime');

        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'channel_ID', 'channel name', 'channel description',
            importance: Importance.Max,
            playSound: true,
            enableVibration: true,
            priority: Priority.High,
            ticker: 'test ticker');

        var iOSChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSChannelSpecifics);
        if (DateTime.parse(a).millisecondsSinceEpoch >
            currentTime.millisecondsSinceEpoch) {
          await cancelNotifications(0);
          print(
              "current time is less than start time so, cannot play notification");
        }
        if (currentTime.millisecondsSinceEpoch >=
                DateTime.parse(a).millisecondsSinceEpoch &&
            currentTime.millisecondsSinceEpoch <=
                DateTime.parse(b).millisecondsSinceEpoch) {
          print("play Notification");
          await flutterLocalNotificationsPlugin.show(0, "Hello there!",
              "Please subscribe my channel", platformChannelSpecifics);
        }
        if (currentTime.millisecondsSinceEpoch >
            DateTime.parse(b).millisecondsSinceEpoch) {
          print(
              "current time is greater than end time so, cannot play notification");
          await cancelNotifications(0);
        }
      });
    } catch (_) {
      print(_);
    }
  }

  notificationCompare() {
    var now = DateTime.now();
    var currentTime = DateTime(now.year, now.month, now.day, now.hour,
        now.minute); //  eg:- 2020-06-12 18:11:00.000
    SharedPreferences.getInstance().then((value) {
      var a = value.getString('startTime'); //  eg:- 2020-06-12 07:00:00.000
      var b = value.getString('endTime'); //   eg:- 2020-06-12 22:00:00.000

      String startHour = a.substring(11, 13); //  eg:- 7 AM
      String endHour = b.substring(11, 13); //  eg:- 10 PM

      var onlyCurrentDate =
          currentTime.toString().substring(0, 10); //  eg:- 2020-01-01
      var onlyWakeUpDay = a.toString().substring(0, 10); //  eg:- 2020-01-01
      var onlyBedDate = b.toString().substring(0, 10); //  eg:- 2020-01-01

      if (onlyBedDate == onlyCurrentDate && onlyWakeUpDay == onlyCurrentDate) {
        print("same date");
      } else {
        print("date different");
        var setStart =
            DateTime(now.year, now.month, now.day, int.parse(startHour), 00);
        setStartTime(setStart);
        var setEnd =
            DateTime(now.year, now.month, now.day, int.parse(endHour), 00);
        setEndTime(setEnd);
      }
    });
  }

  Future cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
