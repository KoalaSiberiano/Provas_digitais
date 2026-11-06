import 'package:flutter/material.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  int _selectedTab = 0;

  final _titleController = TextEditingController();
  final List<Map<String, dynamic>> _questions = [];
  final _pdfParserController = TextEditingController();
  List<Map<String, dynamic>> _parsedQuestions = [];

  void _addQuestionZero() {
    setState(() {
      _questions.add({'question': '', 'type': 'multiple'});
    });
  }

  void _parseCustomPdfText() {
    final text = _pdfParserController.text;
    final extracted = <Map<String, dynamic>>[];
    final questionRegExp = RegExp(r'\/\/(.*?)\/\/');
    final matches = questionRegExp.allMatches(text).toList();

    for (var i = 0; i < matches.length; i++) {
      final questionText = matches[i].group(1)?.trim() ?? '';
      final start = matches[i].end;
      final end = i + 1 < matches.length ? matches[i + 1].start : text.length;
      final blockContent = text.substring(start, end);

      final inputMatches = RegExp(r'\[(.*?)\]').allMatches(blockContent);
      final inputs =
          inputMatches.map((match) => match.group(1)?.trim() ?? '').toList();

      final optionMatches = RegExp(r'\((.*?)\)').allMatches(blockContent);
      final options =
          optionMatches.map((match) => match.group(1)?.trim() ?? '').toList();

      extracted.add({
        'question': questionText,
        'inputs': inputs,
        'options': options,
      });
    }

    setState(() {
      _parsedQuestions = extracted;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PDF processado com sucesso pelo algoritmo de Regex!'),
        backgroundColor: Color(0xFF24211D),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _pdfParserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Formulário de Prova'),
        backgroundColor: const Color(0xFFD9D1C4),
        foregroundColor: const Color(0xFF24211D),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFD9D1C4).withValues(alpha: 0.3),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _selectedTab = 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTab == 0
                        ? const Color(0xFF24211D)
                        : const Color(0xFFD9D1C4),
                    foregroundColor: _selectedTab == 0
                        ? const Color(0xFFF5F2EC)
                        : const Color(0xFF24211D),
                  ),
                  child: const Text('Criar do Zero'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => _selectedTab = 1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedTab == 1
                        ? const Color(0xFF24211D)
                        : const Color(0xFFD9D1C4),
                    foregroundColor: _selectedTab == 1
                        ? const Color(0xFFF5F2EC)
                        : const Color(0xFF24211D),
                  ),
                  child: const Text('Importar PDF (Algoritmo)'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTab == 0 ? _buildCreateFromZero() : _buildImportPdf(),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateFromZero() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Título da Prova / Formulário',
            filled: true,
            fillColor: const Color(0xFFD9D1C4).withValues(alpha: 0.3),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 20),
        ..._questions.asMap().entries.map((entry) {
          final index = entry.key;
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: const Color(0xFFD9D1C4).withValues(alpha: 0.2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Questão ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Digite a pergunta...',
                      filled: true,
                      fillColor: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        ElevatedButton.icon(
          onPressed: _addQuestionZero,
          icon: const Icon(Icons.add),
          label: const Text('Adicionar Pergunta'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A6257),
            foregroundColor: const Color(0xFFF5F2EC),
          ),
        ),
      ],
    );
  }

  Widget _buildImportPdf() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Cole o texto extraído do PDF:\n'
            'Use //pergunta// para questões, [...] para respostas e (...) para opções.',
            style: TextStyle(color: Color(0xFF6A6257), fontSize: 13),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pdfParserController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Ex: // Quanto é 2+2? // [Digite aqui] ( ) 3 (X) 4',
              filled: true,
              fillColor: const Color(0xFFD9D1C4).withValues(alpha: 0.3),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _parseCustomPdfText,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF24211D),
              foregroundColor: const Color(0xFFF5F2EC),
            ),
            child: const Text('Converter Texto em Formulário'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Questões Identificadas pelo Algoritmo:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _parsedQuestions.length,
              itemBuilder: (context, index) {
                final question = _parsedQuestions[index];
                final inputs = question['inputs'] as List<String>;
                final options = question['options'] as List<String>;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: const Color(0xFFD9D1C4).withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q${index + 1}: ${question['question']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        if (inputs.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Campo Dissertativo [...]: ${inputs.join(", ")}',
                            style: const TextStyle(color: Color(0xFF6A6257)),
                          ),
                        ],
                        if (options.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Alternativas (...): ${options.join(" | ")}',
                            style: const TextStyle(color: Color(0xFF6A6257)),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
