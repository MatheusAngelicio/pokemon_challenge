import 'package:collection/collection.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_data_entity.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_state.dart';

List<PokemonDataEntity> getRelatedPokemons(
  PokemonListEntity pokemonListEntity,
  String pokemonNumber,
) {
  final allPokemons = pokemonListEntity.pokemonsEntity;
  final result = <PokemonDataEntity>[];

  final selectedPokemon = allPokemons.firstWhereOrNull(
    (p) => p.number == pokemonNumber,
  );

  if (selectedPokemon == null) {
    return result;
  }

  PokemonDataEntity? findByNum(String num) {
    return allPokemons.firstWhereOrNull((p) => p.number == num);
  }

  if (selectedPokemon.prevEvolution != null) {
    for (var prev in selectedPokemon.prevEvolution!) {
      final prevPokemon = findByNum(prev.number);
      if (prevPokemon != null) result.add(prevPokemon);
    }
  }

  if (selectedPokemon.nextEvolution != null) {
    for (var next in selectedPokemon.nextEvolution!) {
      final nextPokemon = findByNum(next.number);
      if (nextPokemon != null) result.add(nextPokemon);
    }
  }

  return result;
}

List<PokemonDataEntity> sortAndFilterPokemons({
  required List<PokemonDataEntity> pokemons,
  required String searchQuery,
  required PokemonSortState sortState,
}) {
  final filteredList = pokemons
      .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  if (sortState.isAlphabeticalSelected) {
    filteredList.sort((a, b) => a.name.compareTo(b.name));
  } else if (sortState.isCodeSelected) {
    filteredList.sort((a, b) => a.number.compareTo(b.number));
  }

  return filteredList;
}
