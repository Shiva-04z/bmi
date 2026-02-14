import 'package:bmi/data/local/hive_store.dart';
import 'package:bmi/data/local/preferences_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStore {
  TokenStore._();

  static final FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _idTokenKey = "my_id_token";
  static const _serverClientId = "my_server_id";


  static Future<String?> getIdToken() async {
    return await _storage.read(key: _idTokenKey);
  }


  static Future<void> saveIdToken(String idToken) async {
    await _storage.write(key: _idTokenKey, value: idToken);
  }
  static Future<void> saveServerId(String serverKey) async {
    await _storage.write(key: _serverClientId, value: serverKey);
  }

  static Future<String?> getServerId() async {
    return await _storage.read(key: _serverClientId);
  }




  static Future<void> clearStore() async {
    await _storage.delete(key: _idTokenKey);
  }
}
