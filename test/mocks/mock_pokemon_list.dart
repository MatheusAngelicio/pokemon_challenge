import 'package:pokemon_challenge/domain/entity/pokemon_evolution_entity.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';

import '../helpers/pokemon_factory.dart';

class MockPokemonList {
  static PokemonListEntity basicList() {
    final bulbasaur = makePokemon(
      id: 1,
      number: '001',
      name: 'Bulbasaur',
      nextEvolution: [PokemonEvolutionEntity(number: '002', name: 'Ivysaur')],
    );

    final ivysaur = makePokemon(
      id: 2,
      number: '002',
      name: 'Ivysaur',
      prevEvolution: [PokemonEvolutionEntity(number: '001', name: 'Bulbasaur')],
      nextEvolution: [PokemonEvolutionEntity(number: '003', name: 'Venusaur')],
    );

    final venusaur = makePokemon(
      id: 3,
      number: '003',
      name: 'Venusaur',
      prevEvolution: [PokemonEvolutionEntity(number: '002', name: 'Ivysaur')],
    );

    return PokemonListEntity(pokemonsEntity: [bulbasaur, ivysaur, venusaur]);
  }

  static PokemonListEntity pikachuList() {
    final raichu = makePokemon(id: 26, number: '026', name: 'Raichu');

    final pikachu = makePokemon(
      id: 11,
      number: '025',
      name: 'Pikachu',
      nextEvolution: [PokemonEvolutionEntity(number: '026', name: 'Raichu')],
    );

    return PokemonListEntity(pokemonsEntity: [raichu, pikachu]);
  }

  static PokemonListEntity emptyList() {
    return PokemonListEntity(pokemonsEntity: []);
  }
}
