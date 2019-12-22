import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences{

  void savePrefrences(String key,dynamic value)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    }
  }
  dynamic getPrefrences(String key)async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var value  = prefs.get(key);
    return value;
  }




}