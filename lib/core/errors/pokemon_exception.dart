final class PokemonException implements Exception {
  final String? message;
  final Object? error;
  final StackTrace? stackTrace;

  PokemonException({
    required this.message,
    required this.error,
    required this.stackTrace,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonException &&
        other.message == message &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode {
    return message.hashCode ^ error.hashCode ^ stackTrace.hashCode;
  }

  @override
  String toString() => '$message ${error.toString()} ${stackTrace.toString()}';
}
