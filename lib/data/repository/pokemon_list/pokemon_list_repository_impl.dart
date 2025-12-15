import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/constants/pokemon_strings.dart';
import 'package:pokemon_challenge/core/errors/pokemon_exception.dart';
import 'package:pokemon_challenge/core/errors/pokemon_failure.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';
import 'package:pokemon_challenge/domain/repository/pokemon_list_repository.dart';

final class PokemonListRepositoryImpl implements PokemonListRepository {
  final PokemonListDatasource _pokemonListDatasource;

  PokemonListRepositoryImpl({
    required PokemonListDatasource pokemonListDatasource,
  }) : _pokemonListDatasource = pokemonListDatasource;

  @override
  Future<Either<PokemonFailure, PokemonListEntity>> call() async {
    try {
      final entity = await _pokemonListDatasource();
      return Right(entity);
    } on PokemonException catch (e) {
      return Left(
        PokemonFailure(e.message ?? PokemonStrings.genericErrorMessage),
      );
    } catch (_) {
      return Left(PokemonFailure(PokemonStrings.genericErrorMessage));
    }
  }
}
