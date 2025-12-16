import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_challenge/core/errors/pokemon_failure.dart';

void main() {
  group('PokemonFailure', () {
    test('two failures with same message should be equal', () {
      final failure1 = PokemonFailure('Something went wrong');
      final failure2 = PokemonFailure('Something went wrong');

      expect(failure1, failure2);
    });

    test('two failures with different messages should not be equal', () {
      final failure1 = PokemonFailure('Error A');
      final failure2 = PokemonFailure('Error B');

      expect(failure1 == failure2, isFalse);
    });

    test('hashCode should be equal for equal failures', () {
      final failure1 = PokemonFailure('Same error');
      final failure2 = PokemonFailure('Same error');

      expect(failure1.hashCode, failure2.hashCode);
    });

    test('toString should return the message', () {
      final failure = PokemonFailure('Network error');

      expect(failure.toString(), 'Network error');
    });
  });
}
