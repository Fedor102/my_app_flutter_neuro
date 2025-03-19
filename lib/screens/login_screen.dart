import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart'; // Импортируйте ваш сервис аутентификации
import 'home_screen.dart'; // Импортируйте домашний экран
import 'reset_key_screen.dart'; // Импортируйте экран сброса ключа

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadApiKeyAndPin();
  }

  // Загрузка API-ключа и PIN из SharedPreferences
  Future<void> _loadApiKeyAndPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apiKey = prefs.getString('api_key');
    String? pin = prefs.getString('pin');

    if (apiKey != null && pin != null) {
      _apiKeyController.text = apiKey;
      _pinController.text = pin;
    }
  }

  // Проверка API-ключа и PIN
  Future<void> _login() async {
    String apiKey = _apiKeyController.text;
    String pin = _pinController.text;

    // Проверка валидности API-ключа
    bool isValid = await AuthService.checkApiKey(apiKey); // Реализуйте эту функцию в auth_service.dart
    if (isValid) {
      // Если ключ валиден, проверяем PIN
      if (await AuthService.checkPin(pin)) { // Реализуйте эту функцию в auth_service.dart
        // Если PIN верный, переходим на домашний экран
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Неверный PIN-код.';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Неверный API-ключ.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход в приложение'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _apiKeyController,
              decoration: InputDecoration(
                labelText: 'API-ключ',
                errorText: _errorMessage,
              ),
            ),
            TextField(
              controller: _pinController,
              decoration: InputDecoration(
                labelText: 'PIN-код',
                errorText: _errorMessage,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Войти'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetKeyScreen()),
                );
              },
              child: Text('Сбросить ключ API'),
            ),
          ],
        ),
      ),
    );
  }
}
