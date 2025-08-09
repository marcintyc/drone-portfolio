import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/training_category.dart';
import '../providers/session_provider.dart';
import 'recall_screen.dart';

class MemorizeScreen extends StatefulWidget {
  const MemorizeScreen({super.key});

  @override
  State<MemorizeScreen> createState() => _MemorizeScreenState();
}

class _MemorizeScreenState extends State<MemorizeScreen> {
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    final SessionProvider provider = context.read<SessionProvider>();
    _navTimer = Timer.periodic(const Duration(milliseconds: 300), (Timer t) {
      if (provider.secondsLeft <= 0) {
        t.cancel();
        provider.stopMemorization();
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const RecallScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zapamiętywanie')),
      body: Consumer<SessionProvider>(
        builder: (BuildContext context, SessionProvider provider, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Pozostało: ${provider.secondsLeft}s',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildContent(provider)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    provider.stopMemorization();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                          builder: (_) => const RecallScreen()),
                    );
                  },
                  child: const Text('Przejdź do odtwarzania'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(SessionProvider provider) {
    final TrainingCategory category = provider.config.category;
    final List<String> items = provider.items;

    switch (category) {
      case TrainingCategory.digits:
        final String digits = items.isNotEmpty ? items.first : '';
        return SingleChildScrollView(
          child: Text(
            digits,
            style: const TextStyle(fontSize: 28, letterSpacing: 2),
          ),
        );
      case TrainingCategory.words:
      case TrainingCategory.pseudowords:
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(items[index]),
            );
          },
        );
      case TrainingCategory.images:
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final String url = items[index];
            return Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.network(url, fit: BoxFit.cover),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    child: Text('${index + 1}'),
                  ),
                ),
              ],
            );
          },
        );
    }
  }
}