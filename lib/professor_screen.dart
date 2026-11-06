import 'package:flutter/material.dart';
import 'create_form_screen.dart';
import 'login_screen.dart';

class ProfessorScreen extends StatelessWidget {
  const ProfessorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel do Professor - Gestão'),
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
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateFormScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Criar Novo Formulário / Upload'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF24211D),
                foregroundColor: const Color(0xFFF5F2EC),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Resultados Recentes & Infrações',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF24211D),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    tileColor: const Color(0xFFD9D1C4).withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text('Aluno: João da Silva'),
                    subtitle: const Text('Nota: 8.5 | Infrações detectadas: 0'),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    tileColor: const Color(0xFFD9D1C4).withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text('Aluno: Maria Oliveira'),
                    subtitle: const Text('Nota: 5.0 | Infrações detectadas: 2 (Foco perdido)'),
                    trailing: const Icon(Icons.warning, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}