import 'package:pokemon_challenge/data/model/pokemon_list_model.dart';

abstract interface class PokemonListDatasource {
  Future<PokemonListModel> call();
}
