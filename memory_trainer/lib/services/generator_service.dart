import 'dart:math';

class GeneratorService {
  final Random _random = Random();

  String generateDigits(int length) {
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(_random.nextInt(10));
    }
    return buffer.toString();
  }

  List<String> generateWords(int count) {
    final List<String> vocab = _defaultWords;
    return List<String>.generate(count, (int i) {
      return vocab[_random.nextInt(vocab.length)];
    });
  }

  List<String> generatePseudoWords(int count) {
    const List<String> consonantClusters = [
      'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'r', 's', 't',
      'w', 'z', 'ch', 'sz', 'cz', 'tr', 'pr', 'kr', 'gr', 'br', 'pl', 'kl', 'gl'
    ];
    const List<String> vowelClusters = ['a', 'e', 'i', 'o', 'u', 'y', 'ą', 'ę'];

    String makeSyllable() {
      final String c = consonantClusters[_random.nextInt(consonantClusters.length)];
      final String v = vowelClusters[_random.nextInt(vowelClusters.length)];
      final bool addTail = _random.nextBool();
      final String tail = addTail
          ? consonantClusters[_random.nextInt(consonantClusters.length)]
          : '';
      return c + v + tail;
    }

    return List<String>.generate(count, (int i) {
      final int syllables = 2 + _random.nextInt(2); // 2-3 syllables
      return List<String>.generate(syllables, (int _) => makeSyllable()).join();
    });
  }
}

const List<String> _defaultWords = <String>[
  'dom', 'las', 'pies', 'kot', 'miasto', 'rzeka', 'most', 'dzban', 'kwiat',
  'okno', 'droga', 'słońce', 'księżyc', 'gwiazda', 'wiatr', 'deszcz', 'śnieg',
  'krzesło', 'stół', 'książka', 'szkoła', 'pociąg', 'samolot', 'morze', 'góra',
  'zamek', 'ogród', 'jabłko', 'chleb', 'mleko', 'ser', 'ryba', 'zegar', 'długopis',
  'telefon', 'okulary', 'plecak', 'kurtka', 'but', 'rower', 'auto'
];