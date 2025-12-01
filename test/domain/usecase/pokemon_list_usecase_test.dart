import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_challenge/core/erros/failure.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_list_entity.dart';
import 'package:pokemon_challenge/domain/repository/pokemon_list_repository.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase.dart';
import 'package:pokemon_challenge/domain/usecase/pokemon_list_usecase_impl.dart';

class MockPokemonListRepository extends Mock implements PokemonListRepository {}

void main() {
  late PokemonListUsecase usecase;
  late MockPokemonListRepository mockRepository;

  setUp(() {
    mockRepository = MockPokemonListRepository();
    usecase = PokemonListUsecaseImpl(pokemonListRepository: mockRepository);
  });

  test(
    'should return PokemonListEntity when repository returns success',
    () async {
      final mockEntity = PokemonListEntity(pokemonsEntity: []);
      when(() => mockRepository()).thenAnswer((_) async => Right(mockEntity));

      final result = await usecase();

      expect(result.isRight(), true);
      expect(result.fold((l) => null, (r) => r), mockEntity);
      verify(() => mockRepository()).called(1);
    },
  );

  test('should return Failure when repository returns failure', () async {
    final mockFailure = Failure("Erro inesperado");
    when(() => mockRepository()).thenAnswer((_) async => Left(mockFailure));

    final result = await usecase();

    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => null), mockFailure);
    verify(() => mockRepository()).called(1);
  });
}
