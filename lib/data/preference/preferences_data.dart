
import 'package:msaver/constant/string_constant.dart';
import 'package:msaver/data/preference/shared_preferences.dart';

class PreferencesData {
 
 static setUserName({String? userName}) async {
    await sharedPreferences.setData(StringConstant.userName, userName);
  }

  static Future<String> getUserName() async =>
      await sharedPreferences.getData(StringConstant.userName) ?? "";



}
