import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/session_config.dart';
import '../models/session_result.dart';
import '../models/training_category.dart';
import '../services/generator_service.dart';
import '../services/image_service.dart';

class SessionProvider extends ChangeNotifier {
  SessionConfig _config = const SessionConfig(
    category: TrainingCategory.digits,
    durationSeconds: 30,
    itemCount: 20,
  );

  SessionConfig get config => _config;

  void updateConfig(SessionConfig config) {
    _config = config;
    notifyListeners();
  }

  final GeneratorService _generatorService = GeneratorService();
  final ImageService _imageService = ImageService();

  List<String> _items = <String>[];
  List<String> get items => _items;

  Timer? _timer;
  int _secondsLeft = 0;
  int get secondsLeft => _secondsLeft;

  bool _isMemorizing = false;
  bool get isMemorizing => _isMemorizing;

  Future<void> startMemorization() async {
    _isMemorizing = true;
    _secondsLeft = _config.durationSeconds;
    _items = await _prepareItems();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _secondsLeft--;
      if (_secondsLeft <= 0) {
        t.cancel();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void stopMemorization() {
    _timer?.cancel();
    _isMemorizing = false;
    notifyListeners();
  }

  Future<List<String>> _prepareItems() async {
    switch (_config.category) {
      case TrainingCategory.digits:
        final String digits = _generatorService.generateDigits(_config.itemCount);
        return <String>[digits];
      case TrainingCategory.words:
        return _generatorService.generateWords(_config.itemCount);
      case TrainingCategory.pseudowords:
        return _generatorService.generatePseudoWords(_config.itemCount);
      case TrainingCategory.images:
        return await _imageService.fetchRandomImageUrls(_config.itemCount);
    }
  }

  SessionResult scoreAgainstUserInput(String userInput) {
    List<String> userItems;
    if (_config.category == TrainingCategory.digits) {
      userItems = <String>[userInput.replaceAll(RegExp(r'\s+'), '')];
    } else {
      userItems = userInput
          .split(RegExp(r'[\s,;\n]+'))
          .where((String s) => s.trim().isNotEmpty)
          .toList();
    }

    List<String> targetAsList;
    if (_config.category == TrainingCategory.digits) {
      targetAsList = _items;
    } else {
      targetAsList = _items;
    }

    return SessionResult(
      category: _config.category,
      targetItems: targetAsList,
      userItems: userItems,
    );
  }
}