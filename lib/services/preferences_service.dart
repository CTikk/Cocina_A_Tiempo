import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<bool> getAlarmSound() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('alarmSound') ?? true;
  }

  static Future<String> getMeasurementUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('measurementUnit') ?? 'Litros';
  }

  static Future<String> getThemeColorKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('themeColorKey') ?? 'Verde';
  }

  static Future<bool> getShowTips() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('showTips') ?? true;
  }
}