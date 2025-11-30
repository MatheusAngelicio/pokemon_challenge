import 'package:equatable/equatable.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';

sealed class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

class PokemonListInitialState extends PokemonListState {
  const PokemonListInitialState();
}

class PokemonListLoadingState extends PokemonListState {
  const PokemonListLoadingState();
}

class PokemonListLoadedState extends PokemonListState {
  final PokemonListEntity pokemonListEntity;
  const PokemonListLoadedState({required this.pokemonListEntity});

  @override
  List<Object> get props => [pokemonListEntity];
}

class PokemonListErrorState extends PokemonListState {
  final String message;
  const PokemonListErrorState({required this.message});
}
