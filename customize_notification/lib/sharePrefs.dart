import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future setStartTime(String startTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("startTime", startTime);
  }

  Future setEndTime(String endTime) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("endTime", endTime);
  }

  Future onlyTimeTimePeriodic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("oneTimePerodic", true);
  }
}
