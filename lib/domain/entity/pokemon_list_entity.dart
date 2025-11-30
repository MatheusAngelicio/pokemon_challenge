import 'package:flutter/foundation.dart';
import 'pokemon_data_entity.dart';

class PokemonListEntity {
  final List<PokemonDataEntity> pokemonsEntity;

  PokemonListEntity({required this.pokemonsEntity});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonListEntity &&
        listEquals(other.pokemonsEntity, pokemonsEntity);
  }

  @override
  int get hashCode => Object.hashAll(pokemonsEntity);
}
