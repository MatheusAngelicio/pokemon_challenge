import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/pokemon_list_helper.dart';
import '../../../mocks/mock_pokemon_list.dart';

void main() {
  test('should return previous and next evolutions', () {
    final list = MockPokemonList.basicList();

    final result = getRelatedPokemons(list, '002');

    expect(result.length, 2);
    expect(result[0].number, '001');
    expect(result[1].number, '003');
  });

  test('should return empty for nonexistent pokemon', () {
    final list = MockPokemonList.emptyList();

    final result = getRelatedPokemons(list, '999');

    expect(result, isEmpty);
  });

  test('should return only existing next evolution', () {
    final list = MockPokemonList.pikachuList();

    final result = getRelatedPokemons(list, '025');

    expect(result.length, 1);
    expect(result.first.number, '026');
  });
}
