import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource_impl.dart';
import 'package:pokemon_challenge/data/repository/pokemon_list/pokemon_list_repository_impl.dart';
import 'package:pokemon_challenge/domain/repository/pokemon_list_repository.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase_impl.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';

sealed class PokemonInject {
  static void inject(GetIt getIt) {
    getIt.registerLazySingleton<Dio>(() => Dio());

    getIt.registerFactory<PokemonListDatasource>(
      () => PokemonListDatasourceImpl(dio: getIt.get<Dio>()),
    );

    getIt.registerFactory<PokemonListRepository>(
      () => PokemonListRepositoryImpl(
        pokemonListDatasource: getIt.get<PokemonListDatasource>(),
      ),
    );

    getIt.registerFactory<PokemonListUsecase>(
      () => PokemonListUsecaseImpl(
        pokemonListRepository: getIt.get<PokemonListRepository>(),
      ),
    );

    getIt.registerFactory<PokemonListCubit>(
      () =>
          PokemonListCubit(pokemonListUsecase: getIt.get<PokemonListUsecase>()),
    );
  }
}
