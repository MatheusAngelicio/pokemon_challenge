import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_challenge/core/endpoint/pokemon_endpoints.dart';
import 'package:pokemon_challenge/data/datasource/pokemon_list/pokemon_list_datasource_impl.dart';
import 'package:pokemon_challenge/data/model/pokemon_list_model.dart';
import '../../../helpers/pokemon_factory.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late Dio client;
  late PokemonListDatasourceImpl datasource;

  setUp(() {
    client = DioMock();
    datasource = PokemonListDatasourceImpl(dio: client);

    registerFallbackValue(Options(responseType: ResponseType.json));
  });

  When<Future<Response>> whenClientGet() =>
      when(() => client.get(any(), options: any(named: 'options')));

  test('should return a PokemonListModel on successful request', () async {
    final fakeMap = mockPokemonMap;
    final fakeResponse = Response(
      data: jsonEncode(fakeMap),
      statusCode: 200,
      requestOptions: RequestOptions(
        path: PokemonEndpoints.pokemonListEndpoint,
      ),
    );

    whenClientGet().thenAnswer((_) async => fakeResponse);

    final result = await datasource();

    expect(result, isA<PokemonListModel>());
    expect(result.pokemonsEntity.first.name, 'Bulbasaur');
    expect(result.pokemonsEntity.first.number, '001');

    verify(
      () => client.get(
        PokemonEndpoints.pokemonListEndpoint,
        options: any(named: 'options'),
      ),
    ).called(1);
  });

  test('should throw Exception when Dio throws', () async {
    whenClientGet().thenThrow(
      DioException(requestOptions: RequestOptions(path: '')),
    );

    final call = datasource.call;

    expect(() => call(), throwsException);

    verify(
      () => client.get(
        PokemonEndpoints.pokemonListEndpoint,
        options: any(named: 'options'),
      ),
    ).called(1);
  });
}
