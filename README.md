# Pokemon Challenge

Pokemon Challenge é um aplicativo Flutter que permite listar Pokémons a partir da API [Pokedex](https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json). O usuário pode filtrar por nome, ordenar alfabeticamente ou por código, e ver detalhes e pokémons relacionados ao clicar em um Pokémon.

> Observações:
> - O layout do modal de detalhes não está 100% fiel ao Figma, pois o componente de "tipos" do Pokémon não estava detalhado.
> - Não foi possível listar habilidades, pois a API não fornece essas informações.
> - O componente de "estatísticas base" exibe apenas altura e peso (não foi fornecido pela api "HP", "Attack" etc).

## Funcionalidades

- Listagem de todos os Pokémons.
- Filtros por nome.
- Ordenação por ordem alfabética ou código.
- Visualização de detalhes do Pokémon em um modal.
- Exibição de Pokémons relacionados.

## Arquitetura
*** O projeto segue uma abordagem inspirada em Clean Architecture, dividida em camadas: ***

lib/
├── core/ # Utilitários, erros, injeção de dependência, analytics
├── data/ # Implementações concretas (datasources, models)
├── domain/ # Regras de negócio (entities, usecases, repositories)
└── presenter/# UI + gerenciamento de estado (pages, dialogs, widgets, blocs)

## Dependências

- **flutter**: SDK principal.
- **cupertino_icons**: Ícones do iOS.
- **dio**: Requisições HTTP.
- **dartz**: Funcionalidades de programação funcional.
- **get_it**: Injeção de dependência.
- **equatable**: Comparação de objetos.
- **collection**: Extensões para coleções.
- **flutter_bloc**: Gerenciamento de estado via Bloc.

## Dev Dependencies

- **flutter_test**: Testes unitários.
- **flutter_lints**: Regras de lint.
- **flutter_native_splash**: Splash screen nativa.
- **mocktail**: Mocking para testes.
- **network_image_mock**: Mock de imagens em testes.
- **bloc_test**: Testes para bloc.

## Instalação

1. Clone o projeto:
   ```bash
   git clone https://github.com/MatheusAngelicio/pokemon_challenge.git

2. Entre na pasta do projeto:
   ```bash
   cd pokemon_challenge

2. Instale as dependências:
   ```bash
   flutter pub get

## Rodando o aplicativo

1. Conecte um dispositivo ou inicie um emulador/simulador.
2. Execute: flutter run
