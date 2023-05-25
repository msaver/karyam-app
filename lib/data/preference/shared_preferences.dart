import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._privateConstructor();

  static final SharedPreferencesUtil instance =
      SharedPreferencesUtil._privateConstructor();

  Future getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<bool> setData(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value.runtimeType == String) {
      return prefs.setString(key, value);
    } else if (value.runtimeType == bool) {
      return prefs.setBool(key, value);
    } else if (value.runtimeType == int) {
      return prefs.setInt(key, value);
    } else {
      return prefs.setStringList(key, value);
    }
  }

  Future<bool> delete(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

SharedPreferencesUtil sharedPreferences = SharedPreferencesUtil.instance;
