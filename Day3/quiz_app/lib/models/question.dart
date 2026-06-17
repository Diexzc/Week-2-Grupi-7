/// Modeli i një pyetjeje quiz.
///
/// Çdo pyetje ka tekstin, 4 opsione dhe indeksin e përgjigjes së saktë.
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  /// Kontrollon nëse përgjigja e dhënë është e saktë.
  bool isCorrect(int selectedIndex) => selectedIndex == correctAnswerIndex;
}
