import 'training_category.dart';

class SessionConfig {
  final TrainingCategory category;
  final int durationSeconds;
  final int itemCount;

  const SessionConfig({
    required this.category,
    required this.durationSeconds,
    required this.itemCount,
  });

  SessionConfig copyWith({
    TrainingCategory? category,
    int? durationSeconds,
    int? itemCount,
  }) {
    return SessionConfig(
      category: category ?? this.category,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}