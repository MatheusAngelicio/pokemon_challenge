import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_challenge/core/erros/failure.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';
import 'package:pokemon_challenge/domain/repository/pokemon_list_repository.dart';

final class PokemonListRepositoryImpl implements PokemonListRepository {
  final PokemonListDatasource _pokemonListDatasource;

  PokemonListRepositoryImpl({
    required PokemonListDatasource pokemonListDatasource,
  }) : _pokemonListDatasource = pokemonListDatasource;

  @override
  Future<Either<Failure, PokemonListEntity>> call() async {
    try {
      final entity = await _pokemonListDatasource();
      return Right(entity);
    } on DioException catch (e) {
      final message = (e.response?.data?.toString() ?? '').trim();
      return Left(Failure(message.isNotEmpty ? message : 'Erro desconhecido'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
