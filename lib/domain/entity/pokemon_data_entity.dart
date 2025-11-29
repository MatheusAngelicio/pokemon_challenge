import 'package:flutter/foundation.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_evolution_entity.dart';

class PokemonDataEntity {
  final int id;
  final String number;
  final String name;
  final String img;
  final List<String> type;
  final String height;
  final String weight;
  final String candy;
  final int? candyCount;
  final String egg;
  final double spawnChance;
  final double avgSpawns;
  final String spawnTime;
  final List<double>? multipliers;
  final List<String> weaknesses;
  final List<PokemonEvolutionEntity>? nextEvolution;
  final List<PokemonEvolutionEntity>? prevEvolution;

  PokemonDataEntity({
    required this.id,
    required this.number,
    required this.name,
    required this.img,
    required this.type,
    required this.height,
    required this.weight,
    required this.candy,
    required this.candyCount,
    required this.egg,
    required this.spawnChance,
    required this.avgSpawns,
    required this.spawnTime,
    required this.multipliers,
    required this.weaknesses,
    required this.nextEvolution,
    required this.prevEvolution,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonDataEntity &&
        other.id == id &&
        other.number == number &&
        other.name == name &&
        other.img == img &&
        listEquals(other.type, type) &&
        other.height == height &&
        other.weight == weight &&
        other.candy == candy &&
        other.candyCount == candyCount &&
        other.egg == egg &&
        other.spawnChance == spawnChance &&
        other.avgSpawns == avgSpawns &&
        other.spawnTime == spawnTime &&
        listEquals(other.multipliers, multipliers) &&
        listEquals(other.weaknesses, weaknesses) &&
        listEquals(other.nextEvolution, nextEvolution) &&
        listEquals(other.prevEvolution, prevEvolution);
  }

  @override
  int get hashCode => Object.hash(
    id,
    number,
    name,
    img,
    Object.hashAll(type),
    height,
    weight,
    candy,
    candyCount,
    egg,
    spawnChance,
    avgSpawns,
    spawnTime,
    multipliers == null ? null : Object.hashAll(multipliers!),
    Object.hashAll(weaknesses),
    nextEvolution == null ? null : Object.hashAll(nextEvolution!),
    prevEvolution == null ? null : Object.hashAll(prevEvolution!),
  );
}
