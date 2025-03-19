import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart'; // Импортируйте ваш сервис аутентификации
import 'login_screen.dart'; // Импортируйте экран входа

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _apiKey;
  String? _pin;
  double? _balance;

  @override
  void initState() {
    super.initState();
    _loadApiKeyAndPin();
    _fetchBalance();
  }

  // Загрузка API-ключа и PIN из SharedPreferences
  Future<void> _loadApiKeyAndPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('api_key');
      _pin = prefs.getString('pin');
    });
  }

  // Получение баланса пользователя
  Future<void> _fetchBalance() async {
    if (_apiKey != null) {
      double balance = await AuthService.getBalance(_apiKey!); // Реализуйте эту функцию в auth_service.dart
      setState(() {
        _balance = balance;
      });
    }
  }

  // Выход из приложения
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_key');
    await prefs.remove('pin');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главный экран'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'API-ключ: ${_apiKey ?? "Не установлен"}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'PIN-код: ${_pin ?? "Не установлен"}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Баланс: ${_balance != null ? _balance!.toStringAsFixed(2) : "Загрузка..."}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
