import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/session_config.dart';
import '../models/training_category.dart';
import '../providers/session_provider.dart';
import 'memorize_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TrainingCategory _category = TrainingCategory.digits;
  int _duration = 30;
  int _count = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Trainer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Kategoria'),
            const SizedBox(height: 8),
            DropdownButtonFormField<TrainingCategory>(
              value: _category,
              items: const <DropdownMenuItem<TrainingCategory>>[
                DropdownMenuItem(
                  value: TrainingCategory.digits,
                  child: Text('Cyfry'),
                ),
                DropdownMenuItem(
                  value: TrainingCategory.words,
                  child: Text('Słowa'),
                ),
                DropdownMenuItem(
                  value: TrainingCategory.pseudowords,
                  child: Text('Fikcyjne słowa'),
                ),
                DropdownMenuItem(
                  value: TrainingCategory.images,
                  child: Text('Obrazy (API)'),
                ),
              ],
              onChanged: (TrainingCategory? value) {
                if (value != null) {
                  setState(() => _category = value);
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: _duration.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Czas (sekundy)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String v) {
                      final int? parsed = int.tryParse(v);
                      if (parsed != null && parsed > 0) {
                        _duration = parsed;
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: _count.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Ilość elementów',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String v) {
                      final int? parsed = int.tryParse(v);
                      if (parsed != null && parsed > 0) {
                        _count = parsed;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start'),
                onPressed: () async {
                  final SessionProvider provider =
                      context.read<SessionProvider>();
                  provider.updateConfig(SessionConfig(
                    category: _category,
                    durationSeconds: _duration,
                    itemCount: _count,
                  ));
                  await provider.startMemorization();
                  if (mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MemorizeScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}