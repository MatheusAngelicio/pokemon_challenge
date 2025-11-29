import 'package:dartz/dartz.dart';
import 'package:pokemon_challenge/core/erros/failure.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';
import 'package:pokemon_challenge/domain/repository/pokemon_list_repository.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase.dart';

final class PokemonListUsecaseImpl implements PokemonListUsecase {
  final PokemonListRepository _pokemonListRepository;

  PokemonListUsecaseImpl({required PokemonListRepository pokemonListRepository})
    : _pokemonListRepository = pokemonListRepository;

  @override
  Future<Either<Failure, PokemonListEntity>> call() {
    return _pokemonListRepository();
  }
}
