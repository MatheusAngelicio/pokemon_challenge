import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_state.dart';
import 'package:pokemon_challenge/presenter/dialogs/pokemon_details_dialog.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/pokemon_list_helper.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/widgets/pokemon_list_header.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_card_item.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_selection_button.dart';
import 'package:pokemon_challenge/presenter/widgets/search_text_field.dart';

class PokemonListContent extends StatefulWidget {
  final PokemonListLoadedState data;
  const PokemonListContent({super.key, required this.data});

  @override
  State<PokemonListContent> createState() => _PokemonListContentState();
}

class _PokemonListContentState extends State<PokemonListContent> {
  late final TextEditingController _searchPokemonController;
  late final PokemonListCubit _pokemonListCubit;
  late final PokemonSortCubit _pokemonSortCubit;

  @override
  void initState() {
    super.initState();
    _searchPokemonController = TextEditingController();
    _pokemonListCubit = context.read<PokemonListCubit>();
    _pokemonSortCubit = context.read<PokemonSortCubit>();
  }

  @override
  void dispose() {
    _searchPokemonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 730,
            child: Stack(
              children: [
                PokemonListHeader(),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/koraidon.png',
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 370,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.background.withValues(alpha: 0),
                          AppColors.background.withValues(alpha: 0.9),
                          AppColors.background,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 410,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore o incrível\nmundo dos Pokémon.",
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Descubra informações detalhadas sobre seus personagens favoritos.",
                        style: AppTextStyles.medium.copyWith(
                          color: AppColors.darkGray,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "+1000k",
                            style: AppTextStyles.xxLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Pokemons",
                            style: AppTextStyles.medium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      SearchTextField(
                        controller: _searchPokemonController,
                        onChanged: (value) {
                          _pokemonListCubit.filterPokemons(value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: BlocBuilder<PokemonSortCubit, PokemonSortState>(
              bloc: _pokemonSortCubit,
              builder: (_, sortState) {
                return BlocBuilder<PokemonListCubit, PokemonListState>(
                  bloc: _pokemonListCubit,
                  builder: (_, listState) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          PokemonSelectionButton(
                            isSelected: sortState.isAlphabeticalSelected,
                            text: 'alfabética (A-Z)',
                            onTap: () {
                              _pokemonSortCubit.selectAlphabetical();
                              _pokemonListCubit.filterPokemons(
                                _searchPokemonController.text,
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          PokemonSelectionButton(
                            isSelected: sortState.isCodeSelected,
                            text: 'código (crescente)',
                            onTap: () {
                              _pokemonSortCubit.selectCode();
                              _pokemonListCubit.filterPokemons(
                                _searchPokemonController.text,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        BlocBuilder<PokemonSortCubit, PokemonSortState>(
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
                      FocusManager.instance.primaryFocus?.unfocus();
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
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
