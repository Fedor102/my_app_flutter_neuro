import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/reset_key_screen.dart';

Future<void> main() async {
  // Инициализация dotenv для загрузки переменных окружения из .env файла
  await dotenv.load(fileName: ".env");
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chat Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Определение маршрутов для навигации
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Начальный экран - экран входа
        '/home': (context) => HomeScreen(), // Экран домашней страницы
        '/reset': (context) => ResetKeyScreen(), // Экран сброса ключа
      },
    );
  }
}