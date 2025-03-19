import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // URL вашего API для проверки ключа и получения баланса
  static const String apiUrl = 'https://openrouter.ai/api/v1'; // Замените на ваш URL

  // Проверка валидности API-ключа
  static Future<bool> checkApiKey(String apiKey) async {
    final response = await http.post(
      Uri.parse('$apiUrl/check_key'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'api_key': apiKey}),
    );

    if (response.statusCode == 200) {
      // Предполагается, что API возвращает JSON с полем "valid"
      final data = jsonDecode(response.body);
      return data['valid'] == true;
    } else {
      return false;
    }
  }

  // Генерация PIN-кода (можно использовать более сложную логику)
  static String generatePin() {
    // Генерация случайного 4-значного PIN-кода
    return (1000 + (9999 - 1000) * (new DateTime.now().millisecondsSinceEpoch % 10000) ~/ 10000).toString();
  }

  // Проверка PIN-кода
  static Future<bool> checkPin(String pin) async {
    // Здесь должна быть логика для проверки PIN-кода
    // Например, можно хранить PIN в базе данных и проверять его
    // Для примера, просто проверим, что PIN состоит из 4 цифр
    return RegExp(r'^\d{4}$').hasMatch(pin);
  }

  // Получение баланса пользователя
  static Future<double> getBalance(String apiKey) async {
    final response = await http.get(
      Uri.parse('$apiUrl/get_balance?api_key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Предполагается, что API возвращает JSON с полем "balance"
      final data = jsonDecode(response.body);
      return data['balance']?.toDouble() ?? 0.0; // Возвращаем баланс, даже если он 0
    } else {
      throw Exception('Не удалось получить баланс');
    }
  }
}
