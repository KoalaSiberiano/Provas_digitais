import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const ProvaSeguraApp());
}

class ProvaSeguraApp extends StatelessWidget {
  const ProvaSeguraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prova Segura MVP',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F2EC),
        primaryColor: const Color(0xFF24211D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A6257),
          primary: const Color(0xFF24211D),
          secondary: const Color(0xFFB4AA9A),
          surface: const Color(0xFFF5F2EC),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}