import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_state.dart';

final class PokemonSortCubit extends Cubit<PokemonSortState> {
  PokemonSortCubit() : super(const PokemonSortInitial());

  void selectAlphabetical() {
    emit(
      const PokemonSortUpdated(
        isAlphabeticalSelected: true,
        isCodeSelected: false,
      ),
    );
  }

  void selectCode() {
    emit(
      const PokemonSortUpdated(
        isAlphabeticalSelected: false,
        isCodeSelected: true,
      ),
    );
  }
}
