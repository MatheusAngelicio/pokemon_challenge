import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_challenge/core/constants/pokemon_strings.dart';
import 'package:pokemon_challenge/core/errors/pokemon_exception.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource.dart';
import 'package:pokemon_challenge/data/model/pokemon_list_model.dart';
import 'package:pokemon_challenge/data/repository/pokemon_list/pokemon_list_repository_impl.dart';

class MockPokemonListDatasource extends Mock implements PokemonListDatasource {}

PokemonException makePokemonException({String? message}) {
  return PokemonException(
    message: message,
    error: Exception('error'),
    stackTrace: StackTrace.current,
  );
}

void main() {
  late PokemonListRepositoryImpl repository;
  late MockPokemonListDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockPokemonListDatasource();
    repository = PokemonListRepositoryImpl(
      pokemonListDatasource: mockDatasource,
    );
  });

  test('should return entity when datasource succeeds', () async {
    final model = PokemonListModel(pokemonsModel: []);

    when(() => mockDatasource()).thenAnswer((_) async => model);

    final result = await repository();

    expect(result.isRight(), true);
    expect(result.fold((l) => null, (r) => r), model);
    verify(() => mockDatasource()).called(1);
  });

  test('should return Failure with message from PokemonException', () async {
    when(
      () => mockDatasource(),
    ).thenThrow(makePokemonException(message: 'Custom error'));

    final result = await repository();

    expect(result.isLeft(), true);
    expect(result.fold((l) => l.message, (r) => null), 'Custom error');
    verify(() => mockDatasource()).called(1);
  });

  test(
    'should return generic Failure when PokemonException has no message',
    () async {
      when(
        () => mockDatasource(),
      ).thenThrow(makePokemonException(message: null));

      final result = await repository();

      expect(result.isLeft(), true);
      expect(
        result.fold((l) => l.message, (r) => null),
        PokemonStrings.genericErrorMessage,
      );
      verify(() => mockDatasource()).called(1);
    },
  );

  test(
    'should return generic Failure when datasource throws DioException',
    () async {
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
      );

      when(() => mockDatasource()).thenThrow(dioError);

      final result = await repository();

      expect(result.isLeft(), true);
      expect(
        result.fold((l) => l.message, (r) => null),
        PokemonStrings.genericErrorMessage,
      );
      verify(() => mockDatasource()).called(1);
    },
  );

  test('should return generic Failure on unexpected exception', () async {
    when(() => mockDatasource()).thenThrow(Exception('boom'));

    final result = await repository();

    expect(result.isLeft(), true);
    expect(
      result.fold((l) => l.message, (r) => null),
      PokemonStrings.genericErrorMessage,
    );
    verify(() => mockDatasource()).called(1);
  });
}
