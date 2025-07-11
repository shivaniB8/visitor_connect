import 'package:host_visitor_connect/common/res/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _sharedPreferences;

  static Future<SharedPreferences> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  static Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  static Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  static removekeyBranchList(String key) {
    _sharedPreferences.remove(keyBranchList);
  }

  static removekeyBranch(String key) {
    _sharedPreferences.remove(keyBranch);
  }

  static Future<bool> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  static int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  static bool? getOnBoarding() {
    return _sharedPreferences.getBool(keyOnboarding) ?? false;
  }

  static bool? setOnBoarding(bool value) {
    _sharedPreferences.setBool(keyOnboarding, value);
  }

  static clearUserData() async {
    for (String key in _sharedPreferences.getKeys()) {
      if (key != keyOnboarding) {
        await _sharedPreferences.remove(key);
      }
    }
  }
}
