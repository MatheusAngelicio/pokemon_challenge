import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_state.dart';
import 'package:pokemon_challenge/presenter/dialogs/pokemon_details_dialog.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/pokemon_list_helper.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_card_item.dart';

class PokemonListGridSection extends StatefulWidget {
  final PokemonListLoadedState data;

  const PokemonListGridSection({super.key, required this.data});

  @override
  State<PokemonListGridSection> createState() => _PokemonListGridSectionState();
}

class _PokemonListGridSectionState extends State<PokemonListGridSection> {
  late final PokemonSortCubit _pokemonSortCubit;
  late final TextEditingController _searchPokemonController;

  @override
  void initState() {
    super.initState();
    _pokemonSortCubit = context.read<PokemonSortCubit>();
    _searchPokemonController = TextEditingController();
  }

  @override
  void dispose() {
    _searchPokemonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonSortCubit, PokemonSortState>(
      bloc: _pokemonSortCubit,
      builder: (_, sortState) {
        final filteredList = sortAndFilterPokemons(
          pokemons: widget.data.filteredList,
          searchQuery: _searchPokemonController.text,
          sortState: sortState,
        );

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final pokemon = filteredList[index];
              return PokemonCardItem(
                imageUrl: pokemon.img,
                name: pokemon.name,
                number: pokemon.number,
                onCardTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => PokemonDetailsDialog(
                      pokemon: pokemon,
                      relatedPokemons: getRelatedPokemons(
                        widget.data.pokemonListEntity,
                        pokemon.number,
                      ),
                    ),
                  );
                },
              );
            }, childCount: filteredList.length),
          ),
        );
      },
    );
  }
}
