sealed class PokemonSortState {
  final bool isAlphabeticalSelected;
  final bool isCodeSelected;

  const PokemonSortState({
    required this.isAlphabeticalSelected,
    required this.isCodeSelected,
  });
}

class PokemonSortInitial extends PokemonSortState {
  const PokemonSortInitial()
    : super(isAlphabeticalSelected: false, isCodeSelected: true);
}

class PokemonSortUpdated extends PokemonSortState {
  const PokemonSortUpdated({
    required super.isAlphabeticalSelected,
    required super.isCodeSelected,
  });
}
