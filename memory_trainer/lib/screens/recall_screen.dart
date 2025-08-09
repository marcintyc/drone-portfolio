import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/training_category.dart';
import '../providers/session_provider.dart';
import 'results_screen.dart';

class RecallScreen extends StatefulWidget {
  const RecallScreen({super.key});

  @override
  State<RecallScreen> createState() => _RecallScreenState();
}

class _RecallScreenState extends State<RecallScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SessionProvider provider = context.watch<SessionProvider>();
    final TrainingCategory category = provider.config.category;
    final bool isDigits = category == TrainingCategory.digits;

    return Scaffold(
      appBar: AppBar(title: const Text('Odtwarzanie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              isDigits
                  ? 'Wpisz ciąg cyfr'
                  : 'Wpisz elementy (oddzielaj spacją lub enterem)',
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                expands: true,
                keyboardType: isDigits ? TextInputType.number : TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Zakończ i oceń'),
                onPressed: () {
                  final result = provider.scoreAgainstUserInput(_controller.text);
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ResultsScreen(result: result),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}