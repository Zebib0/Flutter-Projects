import 'package:shared_preferences/shared_preferences.dart';
import 'service.dart';

class StepDataStorage {
  static Future<void> saveStepsForDay(int day, int steps) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('steps_day_$day', steps);
  }

  static Future<int?> getStepsForDay(int day) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('steps_day_$day');
  }

  static Future<Map<int, int>> getAllSteps() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<int, int> stepsData = {};

    for (int day = 0; day < 7; day++) {
      stepsData[day] = prefs.getInt('steps_day_$day') ?? 0;
    }

    return stepsData;
  }
}
