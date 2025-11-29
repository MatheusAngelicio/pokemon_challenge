import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/erros/failure.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';

abstract interface class PokemonListRepository {
  Future<Either<Failure, PokemonListEntity>> call();
}
