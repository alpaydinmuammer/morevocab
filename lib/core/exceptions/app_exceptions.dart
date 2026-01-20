/// Base exception class for app-specific errors
abstract class AppException implements Exception {
  final String message;
  final String? details;

  const AppException(this.message, [this.details]);

  @override
  String toString() => details != null ? '$message: $details' : message;
}

/// Exception thrown when data loading fails
class DataLoadException extends AppException {
  const DataLoadException([String? details])
      : super('Failed to load data', details);
}

/// Exception thrown when data saving fails
class DataSaveException extends AppException {
  const DataSaveException([String? details])
      : super('Failed to save data', details);
}

/// Exception thrown when a word is not found
class WordNotFoundException extends AppException {
  final int wordId;

  const WordNotFoundException(this.wordId)
      : super('Word not found', 'ID: $wordId');
}

/// Exception thrown when initialization fails
class InitializationException extends AppException {
  const InitializationException([String? details])
      : super('Initialization failed', details);
}

/// Exception thrown when operation times out
class TimeoutException extends AppException {
  const TimeoutException([String? details])
      : super('Operation timed out', details);
}
