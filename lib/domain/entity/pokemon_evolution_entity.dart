class PokemonEvolutionEntity {
  final String number;
  final String name;

  PokemonEvolutionEntity({required this.number, required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonEvolutionEntity &&
        other.number == number &&
        other.name == name;
  }

  @override
  int get hashCode => number.hashCode ^ name.hashCode;
}
