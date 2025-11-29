import 'package:flutter/foundation.dart';
import 'pokemon_data_entity.dart';

class PokemonListEntity {
  final List<PokemonDataEntity> pokemon;

  PokemonListEntity({required this.pokemon});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonListEntity && listEquals(other.pokemon, pokemon);
  }

  @override
  int get hashCode => Object.hashAll(pokemon);
}
