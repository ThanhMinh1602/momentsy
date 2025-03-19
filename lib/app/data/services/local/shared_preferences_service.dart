import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  static SharedPreferences? _prefs;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }

  // Thêm phương thức lưu token
  static Future<void> setToken(String token) async {
    await _prefs?.setString('token', token);
  }

  static String? getToken() {
    return _prefs?.getString('token');
  }

  // Thêm phương thức lưu userId
  static Future<void> setUserId(String userId) async {
    await _prefs?.setString('user_id', userId);
  }

  static String? getUserId() {
    return _prefs?.getString('user_id');
  }

  static String get getUserIds => _prefs?.getString('user_id') ?? '';
}
