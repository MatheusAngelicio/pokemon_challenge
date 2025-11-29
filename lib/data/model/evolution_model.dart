import 'package:pokemon_challenge/domain/entity/pokemon_evolution_entity.dart';

final class EvolutionModel extends PokemonEvolutionEntity {
  EvolutionModel({required super.number, required super.name});

  factory EvolutionModel.fromMap(Map<String, dynamic> map) {
    return EvolutionModel(number: map['num'], name: map['name']);
  }
}
