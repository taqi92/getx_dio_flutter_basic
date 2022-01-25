import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPref {
  
  SharedPref._();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  
  static Future<bool> isKeyExists(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      return false;
    }
  }

  static Future<String?> read(var key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> write(String key, value) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeAll() async {
    try {
      await _storage.deleteAll();
      return true;
    } catch (e) {
      return false;
    }
  }
}
