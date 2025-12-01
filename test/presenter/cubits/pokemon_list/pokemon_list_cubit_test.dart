import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_challenge/core/erros/failure.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import '../../../mocks/mock_pokemon_list.dart';

class MockPokemonListUsecase extends Mock implements PokemonListUsecase {}

void main() {
  late MockPokemonListUsecase mockUsecase;
  late PokemonListCubit cubit;

  setUp(() {
    mockUsecase = MockPokemonListUsecase();
    cubit = PokemonListCubit(pokemonListUsecase: mockUsecase);
  });

  tearDown(() {
    cubit.close();
  });

  group('PokemonListCubit tests', () {
    blocTest<PokemonListCubit, PokemonListState>(
      'emits [Loading, Loaded] when usecase returns success',
      build: () {
        final list = MockPokemonList.pikachuList();

        when(() => mockUsecase()).thenAnswer((_) async => Right(list));

        return cubit;
      },
      act: (cubit) => cubit.getPokemonList(),
      expect: () => [
        isA<PokemonListLoadingState>(),
        isA<PokemonListLoadedState>().having(
          (s) => s.filteredList.length,
          'filteredList length',
          MockPokemonList.pikachuList().pokemonsEntity.length,
        ),
      ],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'emits [Loading, Error] when usecase returns failure',
      build: () {
        when(
          () => mockUsecase(),
        ).thenAnswer((_) async => Left(Failure('Erro inesperado')));

        return cubit;
      },
      act: (cubit) => cubit.getPokemonList(),
      expect: () => [
        isA<PokemonListLoadingState>(),
        isA<PokemonListErrorState>().having(
          (s) => s.message,
          'error message',
          'Erro inesperado',
        ),
      ],
    );

    blocTest<PokemonListCubit, PokemonListState>(
      'filterPokemons emits updated list',
      build: () {
        final list = MockPokemonList.pikachuList();

        when(() => mockUsecase()).thenAnswer((_) async => Right(list));

        return cubit;
      },
      act: (cubit) async {
        await cubit.getPokemonList();
        cubit.filterPokemons('pikac');
      },
      skip: 1,
      expect: () => [
        isA<PokemonListLoadedState>(),
        isA<PokemonListLoadedState>().having(
          (s) => s.filteredList.length,
          'filtered list length',
          1,
        ),
      ],
    );
  });
}
