import 'package:flutter/foundation.dart';
import 'pokemon_data_entity.dart';

class PokemonListEntity {
  final List<PokemonDataEntity> pokemonListEntity;

  PokemonListEntity({required this.pokemonListEntity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonListEntity &&
        listEquals(other.pokemonListEntity, pokemonListEntity);
  }

  @override
  int get hashCode => Object.hashAll(pokemonListEntity);
}
