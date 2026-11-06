import 'package:flutter/material.dart';
import 'login_screen.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal do Aluno - Provas'),
        backgroundColor: const Color(0xFFD9D1C4),
        foregroundColor: const Color(0xFF24211D),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Avaliações Disponíveis',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF24211D),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFFD9D1C4).withValues(alpha: 0.4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFB4AA9A)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prova de Gestão e Sistemas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF24211D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Status: Disponível para realização\nModo Seguro Ativado',
                      style: TextStyle(color: Color(0xFF6A6257)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Ação para iniciar a prova (futuro modo foco)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF24211D),
                        foregroundColor: const Color(0xFFF5F2EC),
                      ),
                      child: const Text('Iniciar Prova'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}