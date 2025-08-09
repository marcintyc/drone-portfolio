import 'training_category.dart';

class SessionResult {
  final TrainingCategory category;
  final List<String> targetItems;
  final List<String> userItems;

  const SessionResult({
    required this.category,
    required this.targetItems,
    required this.userItems,
  });

  int get numCorrect {
    if (category == TrainingCategory.images) return 0;
    final int compareCount = targetItems.length < userItems.length
        ? targetItems.length
        : userItems.length;
    int correct = 0;
    for (int i = 0; i < compareCount; i++) {
      if (targetItems[i].trim().toLowerCase() ==
          userItems[i].trim().toLowerCase()) {
        correct++;
      }
    }
    return correct;
  }
}