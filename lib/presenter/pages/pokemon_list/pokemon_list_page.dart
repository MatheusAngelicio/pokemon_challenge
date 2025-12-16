import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_challenge/core/constants/pokemon_strings.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import 'package:pokemon_challenge/presenter/dialogs/pokemon_alert_dialog.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/widgets/pokemon_list_content.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => __PokemonListViewState();
}

class __PokemonListViewState extends State<PokemonListPage> {
  late final PokemonListCubit _pokemonListCubit;

  @override
  void initState() {
    super.initState();
    _pokemonListCubit = context.read<PokemonListCubit>()..getPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PokemonListCubit, PokemonListState>(
        bloc: _pokemonListCubit,
        listener: (context, state) {
          if (state is PokemonListErrorState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => PokemonAlertDialog(
                title: PokemonStrings.errorTitle,
                subtitle: state.message,
                buttonText: PokemonStrings.retryButtonText,
                onPressed: () {
                  Navigator.pop(context);
                  _pokemonListCubit.getPokemonList();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PokemonListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PokemonListLoadedState) {
            return PokemonListContent(data: state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
