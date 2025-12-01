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

final Map<String, dynamic> mockPokemonMap = {
  "pokemon": [
    {
      "id": 1,
      "num": "001",
      "name": "Bulbasaur",
      "img": "",
      "type": ["Grass"],
      "height": "0.7 m",
      "weight": "6.9 kg",
      "candy": "Bulbasaur Candy",
      "candy_count": 25,
      "egg": "2 km",
      "spawn_chance": 0.69,
      "avg_spawns": 69.0,
      "spawn_time": "20:00",
      "multipliers": [1.58],
      "weaknesses": ["Fire", "Ice", "Flying", "Psychic"],
      "next_evolution": [
        {"num": "002", "name": "Ivysaur"},
      ],
      "prev_evolution": null,
    },
  ],
};
