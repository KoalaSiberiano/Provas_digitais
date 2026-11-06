import 'package:flutter/material.dart';
import 'student_screen.dart';
import 'professor_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();

  void _handleLogin() {
    String input = _loginController.text.trim();

    if (input == 'prof123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfessorScreen()),
      );
    } else if (input == 'aluno123' || input.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StudentScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite seu identificador.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.lock_outline_rounded,
                  size: 64,
                  color: Color(0xFF24211D),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Prova Segura',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF24211D),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use "aluno123" ou "prof123" para testar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6A6257),
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: 'E-mail, Matrícula ou Código',
                    labelStyle: const TextStyle(color: Color(0xFF6A6257)),
                    filled: true,
                    fillColor: const Color(0xFFD9D1C4).withValues(alpha: 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFB4AA9A)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF24211D), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF24211D),
                    foregroundColor: const Color(0xFFF5F2EC),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}