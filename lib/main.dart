import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_theme.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/pokemon_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      home: const PokemonListPage(),
      theme: AppTheme.light,
    );
  }
}
