/// Error log entry for tracking wrong answers
class ErrorLogEntry {
  final String word;
  final String translation;
  final int wrongCount;
  final DateTime addedAt;

  const ErrorLogEntry({
    required this.word,
    required this.translation,
    required this.wrongCount,
    required this.addedAt,
  });

  ErrorLogEntry copyWith({int? wrongCount}) {
    return ErrorLogEntry(
      word: word,
      translation: translation,
      wrongCount: wrongCount ?? this.wrongCount,
      addedAt: addedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'translation': translation,
      'wrongCount': wrongCount,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  factory ErrorLogEntry.fromJson(Map<String, dynamic> json) {
    return ErrorLogEntry(
      word: json['word'] as String,
      translation: json['translation'] as String,
      wrongCount: json['wrongCount'] as int,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }
}
