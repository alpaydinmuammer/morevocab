/// A Result type for handling success/failure cases without throwing exceptions
sealed class Result<T> {
  const Result();

  /// Returns true if this is a success result
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a failure result
  bool get isFailure => this is Failure<T>;

  /// Get the value if success, or null if failure
  T? get valueOrNull => switch (this) {
        Success(value: final v) => v,
        Failure() => null,
      };

  /// Get the error if failure, or null if success
  String? get errorOrNull => switch (this) {
        Success() => null,
        Failure(error: final e) => e,
      };

  /// Transform the success value
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Success(value: final v) => Success(transform(v)),
        Failure(error: final e) => Failure(e),
      };

  /// Execute different callbacks based on result type
  R when<R>({
    required R Function(T value) success,
    required R Function(String error) failure,
  }) =>
      switch (this) {
        Success(value: final v) => success(v),
        Failure(error: final e) => failure(e),
      };
}

/// Represents a successful result with a value
class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

/// Represents a failed result with an error message
class Failure<T> extends Result<T> {
  final String error;
  const Failure(this.error);
}
