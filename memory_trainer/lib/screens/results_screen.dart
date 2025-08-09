import 'package:flutter/material.dart';

import '../models/session_result.dart';
import '../models/training_category.dart';

class ResultsScreen extends StatelessWidget {
  final SessionResult result;
  const ResultsScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wynik')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (result.category == TrainingCategory.images)
              Text('Obrazy: ta kategoria nie jest automatycznie oceniana',
                  style: Theme.of(context).textTheme.titleMedium)
            else
              Text('Poprawnych: ${result.numCorrect}/${result.targetItems.length}',
                  style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: result.targetItems.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (BuildContext context, int index) {
                  final String expected = index < result.targetItems.length
                      ? result.targetItems[index]
                      : '';
                  final String got = index < result.userItems.length
                      ? result.userItems[index]
                      : '';
                  final bool ok = result.category == TrainingCategory.images
                      ? false
                      : expected.trim().toLowerCase() ==
                          got.trim().toLowerCase();
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(expected),
                    subtitle: Text(got.isEmpty ? '(brak)' : got),
                    trailing: Icon(
                      ok ? Icons.check_circle : Icons.cancel,
                      color: ok ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.home),
                    label: const Text('Strona główna'),
                    onPressed: () => Navigator.of(context)
                        .popUntil((Route<dynamic> r) => r.isFirst),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}