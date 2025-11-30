import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/widgets/pokemon_list_header.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_alert_dialog.dart';
import 'package:pokemon_challenge/presenter/widgets/search_text_field.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => __PokemonListViewState();
}

class __PokemonListViewState extends State<PokemonListPage> {
  final TextEditingController _controller = TextEditingController();
  late final PokemonListCubit _contactChannelsCubit;

  @override
  void initState() {
    super.initState();
    _contactChannelsCubit = context.read<PokemonListCubit>()..getPokemonList();
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
                    _contactChannelsCubit.getPokemonList();
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
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: PokemonListHeader(),
                ),

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
                      SizedBox(height: 12),
                      SearchTextField(controller: _controller),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
