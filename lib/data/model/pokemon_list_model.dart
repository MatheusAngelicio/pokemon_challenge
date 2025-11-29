import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';

import 'pokemon_data_model.dart';

final class PokemonListModel extends PokemonListEntity {
  PokemonListModel({required List<PokemonDataModel> pokemonModel})
    : super(pokemon: pokemonModel);

  factory PokemonListModel.fromMap(Map<String, dynamic> map) {
    final pokemonModel = (map['pokemon'] as List)
        .map((e) => PokemonDataModel.fromMap(e))
        .toList();

    return PokemonListModel(pokemonModel: pokemonModel);
  }
}
