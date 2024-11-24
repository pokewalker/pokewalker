import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/model/pokemon.dart';
import 'package:pokewalker/pokemon_item.dart';
import 'package:pokewalker/provider/generic_crud_provider.dart';
import 'package:pokewalker/screens/landing_page_screen.dart';

class SelectPokemonScreen extends StatelessWidget {
  SelectPokemonScreen({super.key});

  final double metersToNextLevel = 9.0;

  List<Pokemon> pokemons = [];

  Future<void> _fetchPokemonList() async {
    pokemons = await GenericCrudProvider.helper.getPokemonList();
  }

  @override
  Widget build(BuildContext context) {
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
                  width: screenWidth * 0.8,
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
                SizedBox(height: 10),
                Expanded(
                  child: FutureBuilder<void>(
                    future: _fetchPokemonList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return Container(
                          width: screenWidth * 0.6,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: pokemons.length,
                            itemBuilder: (context, index) {
                              final pokemon = pokemons[index];
                              return PokemonItem(
                                  pokemon: pokemon,
                                  metersToNextLevel:
                                      pokemon.metersToNextLevel.toDouble());
                            },
                          ),
                        );
                      }
                    },
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
