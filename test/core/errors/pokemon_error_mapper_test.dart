import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:pokemon_challenge/core/constants/pokemon_strings.dart';
import 'package:pokemon_challenge/core/errors/pokemon_error_mapper.dart';

void main() {
  group('PokemonErrorMapper', () {
    test('returns noInternetConnection for connection related errors', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionError,
      );

      final result = PokemonErrorMapper.fromDioException(exception);

      expect(result, PokemonStrings.noInternetConnection);
    });

    test('returns notFoundPokemons when status code is 404', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 404,
        ),
      );

      final result = PokemonErrorMapper.fromDioException(exception);

      expect(result, PokemonStrings.notFoundPokemons);
    });

    test('returns serverError when status code is >= 500', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 500,
        ),
      );

      final result = PokemonErrorMapper.fromDioException(exception);

      expect(result, PokemonStrings.serverError);
    });

    test('returns requestProcessError for badResponse without status code', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.badResponse,
      );

      final result = PokemonErrorMapper.fromDioException(exception);

      expect(result, PokemonStrings.requestProcessError);
    });

    test('returns requestCanceled when request is canceled', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.cancel,
      );

      final result = PokemonErrorMapper.fromDioException(exception);

      expect(result, PokemonStrings.requestCanceled);
    });

    test('returns genericErrorMessage for unknown error', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.unknown,
      );

      final result = PokemonErrorMapper.fromDioException(exception);

      expect(result, PokemonStrings.genericErrorMessage);
    });
  });
}
