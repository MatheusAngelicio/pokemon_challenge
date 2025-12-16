import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';
import '../../helpers/pokemon_factory.dart';
import '../../mocks/mock_pokemon_list.dart';

void main() {
  group('PokemonListEntity', () {
    test('two lists with same pokemons should be equal', () {
      final list1 = MockPokemonList.basicList();
      final list2 = MockPokemonList.basicList();

      expect(list1, list2);
    });

    test('lists with different pokemons should not be equal', () {
      final list1 = MockPokemonList.basicList();
      final list2 = MockPokemonList.pikachuList();

      expect(list1 == list2, isFalse);
    });

    test('hashCode should be equal for equal lists', () {
      final list1 = MockPokemonList.basicList();
      final list2 = MockPokemonList.basicList();

      expect(list1.hashCode, list2.hashCode);
    });

    test('order of pokemons matters', () {
      final pokemonA = makePokemon(id: 1, number: '001', name: 'Bulbasaur');

      final pokemonB = makePokemon(id: 2, number: '002', name: 'Ivysaur');

      final list1 = PokemonListEntity(pokemonsEntity: [pokemonA, pokemonB]);

      final list2 = PokemonListEntity(pokemonsEntity: [pokemonB, pokemonA]);

      expect(list1 == list2, isFalse);
    });

    test('empty lists should be equal', () {
      final list1 = MockPokemonList.emptyList();
      final list2 = MockPokemonList.emptyList();

      expect(list1, list2);
      expect(list1.hashCode, list2.hashCode);
    });
  });
}
