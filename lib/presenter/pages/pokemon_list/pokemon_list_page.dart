import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import 'package:pokemon_challenge/presenter/dialogs/pokemon_alert_dialog.dart';
import 'package:pokemon_challenge/presenter/dialogs/pokemon_details_dialog.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/pokemon_list_helper.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/widgets/pokemon_list_header.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_card_item.dart';
import 'package:pokemon_challenge/presenter/widgets/search_text_field.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => __PokemonListViewState();
}

class __PokemonListViewState extends State<PokemonListPage> {
  late final TextEditingController _searchPokemonController;
  late final PokemonListCubit _pokemonListCubit;

  @override
  void initState() {
    super.initState();
    _searchPokemonController = TextEditingController();
    _pokemonListCubit = context.read<PokemonListCubit>()..getPokemonList();
  }

  @override
  void dispose() {
    _searchPokemonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PokemonListCubit, PokemonListState>(
        listener: (context, state) {
          if (state is PokemonListErrorState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return PokemonAlertDialog(
                  title: "Oops! Algo deu errado.",
                  subtitle: state.message,
                  buttonText: "Tentar novamente",
                  onPressed: () {
                    Navigator.pop(context);
                    _pokemonListCubit.getPokemonList();
                  },
                );
              },
            );
          }
        },

        builder: (context, state) {
          if (state is PokemonListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PokemonListLoadedState) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 700,
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
                              SizedBox(height: 12),
                              Text(
                                "Descubra informações detalhadas sobre seus personagens favoritos.",
                                style: AppTextStyles.medium.copyWith(
                                  color: AppColors.darkGray,
                                ),
                              ),
                              SizedBox(height: 12),
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
                                  SizedBox(width: 12),
                                  Text(
                                    "Pokemons",
                                    style: AppTextStyles.medium.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
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
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final pokemon = state.filteredList[index];
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
                                state.pokemonListEntity,
                                pokemon.number,
                              ),
                            ),
                          );
                        },
                      );
                    }, childCount: state.filteredList.length),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 60)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
