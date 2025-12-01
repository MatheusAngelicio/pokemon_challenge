import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_card_item.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_placeholder.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('should render and call onTap', (tester) async {
    const imageUrl = 'http://www.serebii.net/pokemongo/pokemon/025.png';
    const name = 'Pikachu';
    const number = '025';

    var tapped = false;

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PokemonCardItem(
              imageUrl: imageUrl,
              name: name,
              number: number,
              onCardTap: () => tapped = true,
            ),
          ),
        ),
      );
    });

    // check texts
    expect(find.text('Pikachu'), findsOneWidget);
    expect(find.text('#025'), findsOneWidget);

    // verifica se esta mostrando placeholder antes de carregar a imagem
    expect(find.byType(PokemonPlaceholder), findsOneWidget);

    // simulação de onTap
    await tester.tap(find.byType(PokemonCardItem));
    await tester.pump();

    expect(tapped, isTrue);
  });
}
