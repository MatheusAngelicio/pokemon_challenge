import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pokemon_challenge/core/constants/pokemon_strings.dart';
import 'package:pokemon_challenge/core/endpoint/pokemon_endpoints.dart';
import 'package:pokemon_challenge/core/errors/pokemon_error_mapper.dart';
import 'package:pokemon_challenge/core/errors/pokemon_exception.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource.dart';
import 'package:pokemon_challenge/data/model/pokemon_list_model.dart';

final class PokemonListDatasourceImpl implements PokemonListDatasource {
  final Dio _dio;

  PokemonListDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<PokemonListModel> call() async {
    try {
      final response = await _dio.get(
        PokemonEndpoints.pokemonListEndpoint,
        options: Options(responseType: ResponseType.json),
      );

      final data = response.data;
      final decoded = jsonDecode(data);

      return PokemonListModel.fromMap(decoded);
    } on DioException catch (exception, stackTrace) {
      throw PokemonException(
        error: exception,
        stackTrace: stackTrace,
        message: PokemonErrorMapper.fromDioException(exception),
      );
    } catch (exception, stackTrace) {
      throw PokemonException(
        error: exception,
        stackTrace: stackTrace,
        message: PokemonStrings.genericErrorMessage,
      );
    }
  }
}
