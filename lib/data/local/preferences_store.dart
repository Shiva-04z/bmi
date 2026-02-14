import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStore {
  PreferencesStore._();

  static late final SharedPreferences _preferences;
  static const String _loginKey = "my_login_key";
  static const String _preferred = "my_preferred_id";
  static bool _isInitialized = false;

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception("Call PreferencesStore.onInit() before using PreferencesStore.");
    }
  }

  static Future<void> onInit() async {
    if(!_isInitialized) {
      _preferences = await SharedPreferences.getInstance();
      _isInitialized =true;
    }
  }

  static bool getLogin() {
    _ensureInitialized();
    return  _preferences.getBool(_loginKey) ?? false;
  }

  static void setLoggedIn() {
    _ensureInitialized();
    _preferences.setBool(_loginKey, true);
  }

  static void logOut() {
    _ensureInitialized();
    _preferences.setBool(_loginKey, false);
  }
  static String? getPreferredProfileId()
  {
    _ensureInitialized();
   return _preferences.getString(_preferred);
  }

  static void setPreferredProfileId(String preferredId)
  {
    _ensureInitialized();
   _preferences.setString(_preferred,preferredId);
  }
}
