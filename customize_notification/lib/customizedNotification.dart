import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:customize_notification/Notification/notificationHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CustomizedNotification extends StatefulWidget {
  @override
  _CustomizedNotificationState createState() => _CustomizedNotificationState();
}

class _CustomizedNotificationState extends State<CustomizedNotification> {
  String startTime = "";
  String endTime = "";

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        var a = value.getString('startTime');
        print(a);
        var b = value.getString('endTime');
        startTime = DateFormat('jm').format(DateTime.parse(a));
        endTime = DateFormat('jm').format(DateTime.parse(b));
      });
    });
  }

  static periodicCallBack() {
    NotificationHelper().showNotificationBetweenInterval();
    print("Notification started");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Notification Start from",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        startTime,
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Notification Stop from",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        endTime,
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        // width: 100,
                        child: RaisedButton(
                          elevation: 8.0,
                          color: Colors.blue,
                          onPressed: () async {
                            WidgetsFlutterBinding.ensureInitialized();
                            await AndroidAlarmManager.initialize();
                            ontTimePeriodic();
                          },
                          child: Text(
                            "Okay, Trigger Alarm",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ontTimePeriodic() {
    SharedPreferences.getInstance().then((value) async {
      var a = value.getBool("oneTimePerodic") ?? false;
      if (!a) {
        await AndroidAlarmManager.periodic(
            const Duration(minutes: 1), 0, periodicCallBack,
            wakeup: true);
      } else {
        print("cannot run more than onnce");
      }
    });
  }
}
