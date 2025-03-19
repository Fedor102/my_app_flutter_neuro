import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart'; // Импортируйте ваш сервис аутентификации
import 'login_screen.dart'; // Импортируйте экран входа

class ResetKeyScreen extends StatefulWidget {
  @override
  _ResetKeyScreenState createState() => _ResetKeyScreenState();
}

class _ResetKeyScreenState extends State<ResetKeyScreen> {
  final TextEditingController _newApiKeyController = TextEditingController();
  String? _errorMessage;

  // Метод для сброса API-ключа
  Future<void> _resetApiKey() async {
    String newApiKey = _newApiKeyController.text;

    // Проверка валидности нового API-ключа
    bool isValid = await AuthService.checkApiKey(newApiKey); // Реализуйте эту функцию в auth_service.dart
    if (isValid) {
      // Сохранение нового API-ключа в SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_key', newApiKey);
      
      // Возврат на экран входа
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
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
        title: Text('Сброс ключа API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _newApiKeyController,
              decoration: InputDecoration(
                labelText: 'Новый API-ключ',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetApiKey,
              child: Text('Сбросить ключ API'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Возврат на экран входа
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}
