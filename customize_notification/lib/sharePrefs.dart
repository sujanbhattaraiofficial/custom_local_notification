import 'package:shared_preferences/shared_preferences.dart';

Future setStartTime(DateTime startTime) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("startTime", startTime.toString());
}

Future setEndTime(DateTime endTime) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("endTime", endTime.toString());
}

Future onlyTimeTimePeriodic() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("oneTimePerodic", true);
}
