import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_evolution_entity.dart';

void main() {
  group('PokemonEvolutionEntity', () {
    test('two evolutions with same values should be equal', () {
      final evolution1 = PokemonEvolutionEntity(number: '002', name: 'Ivysaur');

      final evolution2 = PokemonEvolutionEntity(number: '002', name: 'Ivysaur');

      expect(evolution1, evolution2);
    });

    test('two evolutions with different values should not be equal', () {
      final evolution1 = PokemonEvolutionEntity(number: '002', name: 'Ivysaur');

      final evolution2 = PokemonEvolutionEntity(
        number: '003',
        name: 'Venusaur',
      );

      expect(evolution1 == evolution2, isFalse);
    });

    test('hashCode should be equal for equal evolutions', () {
      final evolution1 = PokemonEvolutionEntity(number: '002', name: 'Ivysaur');

      final evolution2 = PokemonEvolutionEntity(number: '002', name: 'Ivysaur');

      expect(evolution1.hashCode, evolution2.hashCode);
    });
  });
}
