import 'package:shared_preferences/shared_preferences.dart';

abstract class SharPrefTheme {
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static void setBoolDarckTheme(bool darchTheme) async {
    var pref = await prefs;
    await pref.setBool('darcktheme', darchTheme);
  }

  static Future<bool> getBoolDarckTheme() async {
    var pref = await prefs;
    var darcktheme = pref.getBool('darcktheme') ?? false;
    return darcktheme;
  }
}
