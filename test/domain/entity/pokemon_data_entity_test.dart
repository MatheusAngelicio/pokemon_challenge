import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_evolution_entity.dart';

import '../../helpers/pokemon_factory.dart';

void main() {
  group('PokemonDataEntity', () {
    test('two entities with same values should be equal', () {
      final evolution = PokemonEvolutionEntity(number: '002', name: 'Ivysaur');

      final entity1 = makePokemon(
        id: 1,
        number: '001',
        name: 'Bulbasaur',
        multipliers: [1.5, 2.0],
        nextEvolution: [evolution],
      );

      final entity2 = makePokemon(
        id: 1,
        number: '001',
        name: 'Bulbasaur',
        multipliers: [1.5, 2.0],
        nextEvolution: [evolution],
      );

      expect(entity1, entity2);
    });

    test('entities with different primitive values should not be equal', () {
      final entity1 = makePokemon(id: 1, number: '001', name: 'Bulbasaur');

      final entity2 = makePokemon(id: 1, number: '001', name: 'Charmander');

      expect(entity1 == entity2, isFalse);
    });

    test('entities with different list values should not be equal', () {
      final entity1 = makePokemon(id: 1, number: '001', type: ['Grass']);

      final entity2 = makePokemon(id: 1, number: '001', type: ['Fire']);

      expect(entity1 == entity2, isFalse);
    });

    test('hashCode should be equal for equal entities', () {
      final entity1 = makePokemon(id: 1, number: '001', multipliers: [1.5]);

      final entity2 = makePokemon(id: 1, number: '001', multipliers: [1.5]);

      expect(entity1.hashCode, entity2.hashCode);
    });

    test('supports null optional lists', () {
      final entity1 = makePokemon(
        id: 1,
        number: '001',
        multipliers: null,
        nextEvolution: null,
        prevEvolution: null,
      );

      final entity2 = makePokemon(
        id: 1,
        number: '001',
        multipliers: null,
        nextEvolution: null,
        prevEvolution: null,
      );

      expect(entity1, entity2);
      expect(entity1.hashCode, entity2.hashCode);
    });
  });
}
