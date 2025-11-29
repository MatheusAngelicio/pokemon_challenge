import 'package:pokemon_challenge/domain/entity/pokemon_data_entity.dart';

import 'evolution_model.dart';

final class PokemonDataModel extends PokemonDataEntity {
  PokemonDataModel({
    required super.id,
    required super.number,
    required super.name,
    required super.img,
    required super.type,
    required super.height,
    required super.weight,
    required super.candy,
    required super.candyCount,
    required super.egg,
    required super.spawnChance,
    required super.avgSpawns,
    required super.spawnTime,
    required super.multipliers,
    required super.weaknesses,
    required super.nextEvolution,
    required super.prevEvolution,
  });

  factory PokemonDataModel.fromMap(Map<String, dynamic> map) {
    return PokemonDataModel(
      id: map['id'],
      number: map['num'],
      name: map['name'],
      img: map['img'],
      type: List<String>.from(map['type']),
      height: map['height'],
      weight: map['weight'],
      candy: map['candy'],
      candyCount: map['candy_count'],
      egg: map['egg'],
      spawnChance: (map['spawn_chance'] as num).toDouble(),
      avgSpawns: (map['avg_spawns'] as num).toDouble(),
      spawnTime: map['spawn_time'],
      multipliers: map['multipliers'] != null
          ? List<double>.from(
              (map['multipliers'] as List).map((e) => (e as num).toDouble()),
            )
          : null,
      weaknesses: List<String>.from(map['weaknesses']),
      nextEvolution: map['next_evolution'] != null
          ? (map['next_evolution'] as List)
                .map((e) => EvolutionModel.fromMap(e))
                .toList()
          : null,
      prevEvolution: map['prev_evolution'] != null
          ? (map['prev_evolution'] as List)
                .map((e) => EvolutionModel.fromMap(e))
                .toList()
          : null,
    );
  }
}
