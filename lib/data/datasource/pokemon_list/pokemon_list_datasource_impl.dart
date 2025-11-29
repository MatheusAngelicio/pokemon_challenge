import 'package:dio/dio.dart';
import 'package:pokemon_challenge/core/endpoint/pokemon_endpoints.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource.dart';
import 'package:pokemon_challenge/data/model/pokemon_list_model.dart';

final class PokemonListDatasourceImpl implements PokemonListDatasource {
  final Dio _dio;

  PokemonListDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<PokemonListModel> call() async {
    try {
      final response = await _dio.get(PokemonEndpoints.pokemonListEndpoint);

      return PokemonListModel.fromMap(response.data);
    } catch (e) {
      throw Exception('Erro ao buscar lista de pokemons');
    }
  }
}
