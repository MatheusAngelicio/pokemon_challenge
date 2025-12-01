import 'package:pokemon_challenge/domain/entity/pokemon_data_entity.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_evolution_entity.dart';

PokemonDataEntity makePokemon({
  required int id,
  required String number,
  String name = 'Test',
  List<String> type = const ['Grass'],
  String img = '',
  String height = '0',
  String weight = '0',
  String candy = '',
  int? candyCount,
  String egg = '',
  double spawnChance = 0,
  double avgSpawns = 0,
  String spawnTime = '0',
  List<double>? multipliers,
  List<String> weaknesses = const [],
  List<PokemonEvolutionEntity>? nextEvolution,
  List<PokemonEvolutionEntity>? prevEvolution,
}) {
  return PokemonDataEntity(
    id: id,
    number: number,
    name: name,
    img: img,
    type: type,
    height: height,
    weight: weight,
    candy: candy,
    candyCount: candyCount,
    egg: egg,
    spawnChance: spawnChance,
    avgSpawns: avgSpawns,
    spawnTime: spawnTime,
    multipliers: multipliers,
    weaknesses: weaknesses,
    nextEvolution: nextEvolution,
    prevEvolution: prevEvolution,
  );
}
