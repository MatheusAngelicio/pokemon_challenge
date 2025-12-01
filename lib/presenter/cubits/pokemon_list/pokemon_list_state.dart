import 'package:equatable/equatable.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_data_entity.dart';
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
  final List<PokemonDataEntity> filteredList;

  const PokemonListLoadedState({
    required this.pokemonListEntity,
    required this.filteredList,
  });

  PokemonListLoadedState copyWith({
    PokemonListEntity? pokemonListEntity,
    List<PokemonDataEntity>? filteredList,
  }) {
    return PokemonListLoadedState(
      pokemonListEntity: pokemonListEntity ?? this.pokemonListEntity,
      filteredList: filteredList ?? this.filteredList,
    );
  }

  @override
  List<Object> get props => [pokemonListEntity, filteredList];
}

class PokemonListErrorState extends PokemonListState {
  final String message;
  const PokemonListErrorState({required this.message});
}
