import 'package:dio/dio.dart';
import 'package:pokemon_challenge/core/constants/pokemon_strings.dart';

final class PokemonErrorMapper {
  static String fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return PokemonStrings.noInternetConnection;

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;

        if (statusCode == 404) {
          return PokemonStrings.notFoundPokemons;
        }

        if (statusCode != null && statusCode >= 500) {
          return PokemonStrings.serverError;
        }

        return PokemonStrings.requestProcessError;

      case DioExceptionType.cancel:
        return PokemonStrings.requestCanceled;

      case DioExceptionType.unknown:
      default:
        return PokemonStrings.genericErrorMessage;
    }
  }
}
