import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_challenge/core/inject/pokemon_inject.dart';
import 'package:pokemon_challenge/core/theme/app_theme.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_cubit.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_sort/pokemon_sort_cubit.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/pokemon_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final getIt = GetIt.instance;

  PokemonInject.inject(getIt);
  await Firebase.initializeApp();

  runApp(MyApp(getIt: getIt));
}

class MyApp extends StatelessWidget {
  final GetIt getIt;

  const MyApp({super.key, required this.getIt});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<PokemonListCubit>(
            create: (_) => getIt<PokemonListCubit>(),
          ),
          BlocProvider<PokemonSortCubit>(
            create: (_) => getIt<PokemonSortCubit>(),
          ),
        ],
        child: const PokemonListPage(),
      ),
    );
  }
}
