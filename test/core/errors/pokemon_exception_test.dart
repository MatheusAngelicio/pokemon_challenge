import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_challenge/core/errors/pokemon_exception.dart';

void main() {
  group('PokemonException', () {
    test('two exceptions with same values should be equal', () {
      final stackTrace = StackTrace.current;
      final error = Exception('error');

      final exception1 = PokemonException(
        message: 'Something went wrong',
        error: error,
        stackTrace: stackTrace,
      );

      final exception2 = PokemonException(
        message: 'Something went wrong',
        error: error,
        stackTrace: stackTrace,
      );

      expect(exception1 == exception2, isTrue);
    });

    test('exceptions with different values should not be equal', () {
      final exception1 = PokemonException(
        message: 'Error A',
        error: Exception('A'),
        stackTrace: StackTrace.current,
      );

      final exception2 = PokemonException(
        message: 'Error B',
        error: Exception('B'),
        stackTrace: StackTrace.current,
      );

      expect(exception1 == exception2, isFalse);
    });

    test('hashCode should be equal for equal exceptions', () {
      final stackTrace = StackTrace.current;
      final error = Exception('error');

      final exception1 = PokemonException(
        message: 'Same error',
        error: error,
        stackTrace: stackTrace,
      );

      final exception2 = PokemonException(
        message: 'Same error',
        error: error,
        stackTrace: stackTrace,
      );

      expect(exception1.hashCode, exception2.hashCode);
    });

    test('toString should contain message, error and stackTrace', () {
      final stackTrace = StackTrace.current;
      final error = Exception('boom');

      final exception = PokemonException(
        message: 'Custom message',
        error: error,
        stackTrace: stackTrace,
      );

      final result = exception.toString();

      expect(result, contains('Custom message'));
      expect(result, contains('Exception: boom'));
      expect(result, contains(stackTrace.toString()));
    });
  });
}
