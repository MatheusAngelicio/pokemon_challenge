import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';

final class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonListUsecase _pokemonListUsecase;

  PokemonListCubit({required PokemonListUsecase pokemonListUsecase})
    : _pokemonListUsecase = pokemonListUsecase,
      super(const PokemonListInitialState());

  Future<void> getPokemonList() async {
    emit(PokemonListLoadingState());

    final result = await _pokemonListUsecase();

    result.fold((failure) {
      emit(PokemonListErrorState(message: failure.message));
    }, (success) => emit(PokemonListLoadedState(pokemonListEntity: success)));
  }
}
