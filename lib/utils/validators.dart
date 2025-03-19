class Validators {
  // Валидация формата API-ключа
  static String? validateApiKey(String? apiKey) {
    if (apiKey == null || apiKey.isEmpty) {
      return 'API-ключ не может быть пустым.';
    }
    // Добавьте дополнительные проверки формата API-ключа, если необходимо
    return null; // Если валидация прошла успешно
  }

  // Валидация формата PIN-кода
  static String? validatePin(String? pin) {
    if (pin == null || pin.isEmpty) {
      return 'PIN-код не может быть пустым.';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(pin)) {
      return 'PIN-код должен состоять из 4 цифр.';
    }
    return null; // Если валидация прошла успешно
  }
}