import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/pokemon_item.dart';
import 'package:pokewalker/screens/landing_page_screen.dart';

class SelectPokemonScreen extends StatelessWidget {
  SelectPokemonScreen({super.key});

  final double kilometersToNextLevel = 9.0;

  final List<Map<String, String>> pokemons = [
    {
      'name': 'Bulbasaur',
      'level': 'Lvl. 4',
      'kilometers': '8',
      'img':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png'
    },
    {
      'name': 'Charmander',
      'level': 'Lvl. 3',
      'kilometers': '6.0',
      'img':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png'
    },
    {
      'name': 'Squirtle',
      'level': 'Lvl. 2',
      'kilometers': '4.0',
      'img':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png'
    },
    {
      'name': 'Pikachu',
      'level': 'Lvl. 1',
      'kilometers': '9.0',
      'img':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(105, 210, 210, 1.0),
                  Color.fromRGBO(105, 210, 210, 1.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  width: screenWidth * 0.8 < 300 ? screenWidth * 0.8 : 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 3),
                  ),
                  child: Text(
                    'SELECIONE SEU POKÉMON',
                    style: GoogleFonts.bungeeHairline(
                      textStyle: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                    height: 10), // Espaçamento menor entre o título e o grid
                Expanded(
                  child: Container(
                    width: screenWidth * 0.8 < 300 ? screenWidth * 0.8 : 300,
                    child: GridView.builder(
                      padding: EdgeInsets.zero, // Remove padding extra
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Número de ícones por linha
                        crossAxisSpacing: 10, // Espaçamento horizontal
                        mainAxisSpacing: 10, // Espaçamento vertical
                        childAspectRatio: 0.8, // Razão de aspecto dos itens
                      ),
                      itemCount: pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = pokemons[index];
                        return PokemonItem(pokemon: pokemon, kilometersToNextLevel: kilometersToNextLevel);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
              onPressed: () {
                // Lógica de voltar
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LandingPageScreen(),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
