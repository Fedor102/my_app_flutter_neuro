import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Сохранение API-ключа
  static Future<void> saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_key', apiKey);
  }

  // Получение API-ключа
  static Future<String?> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_key');
  }

  // Сохранение PIN-кода
  static Future<void> savePin(String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pin', pin);
  }

  // Получение PIN-кода
  static Future<String?> getPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('pin');
  }

  // Удаление API-ключа и PIN-кода
  static Future<void> clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_key');
    await prefs.remove('pin');
  }
}