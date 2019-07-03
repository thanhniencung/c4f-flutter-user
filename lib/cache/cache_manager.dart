import 'package:shared_preferences/shared_preferences.dart';
import 'icache.dart';

class CacheManager implements ICache {
  SharedPreferences prefs;
  static final CacheManager _INSTANCE = new CacheManager._internal();

  factory CacheManager() {
    return _INSTANCE;
  }

  CacheManager._internal();

  @override
  String get(String key) {
    return "";
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    String key prefs.getString(key);*/
  }

  @override
  set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
