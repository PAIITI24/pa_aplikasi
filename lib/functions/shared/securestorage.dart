import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthKey {
  static final _secure_storage = new FlutterSecureStorage();

  static Future<String> GetAuthKey() async {
    String? data = await _secure_storage.read(key: "auth_key");
    if (data != null) {
      return data;
    } else {
      return "";
    }
  }

  static Future<void> Set(String value) async {
    try {
      _secure_storage.write(key: "auth_key", value: value);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> Clear() async {
    try {
      _secure_storage.delete(key: "auth_key");
    } catch (e) {
      throw e;
    }
  }
}

class OtherKeys {
  static final _secure_storage = new FlutterSecureStorage();

  static Future<String?> GetAuthKey(String key) async {
    return await _secure_storage.read(key: key);
  }

  static Future<void> Set(String key, String value) async {
    try {
      _secure_storage.write(key: key, value: value);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> Delete(String key) async {
    try {
      _secure_storage.delete(key: key);
    } catch (e) {
      throw e;
    }
  }
}
