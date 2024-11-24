import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/model/pokemon.dart';
import 'package:pokewalker/screens/select_pokemon_screen.dart';
import 'package:pokewalker/screens/thank_you_screen.dart';

class PokevolutionScreen extends StatelessWidget {
  final Pokemon selectedPokemon;

  const PokevolutionScreen({super.key, required this.selectedPokemon});

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela para garantir o design responsivo
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fundo com gradiente
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título
                Text(
                  'POKEWALKER',
                  style: GoogleFonts.bungee(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Imagem da Pokebola com o Pokémon
                Container(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  child: Stack(
                    children: [
                      // Imagem da Pokebola
                      Image.network(
                        'https://i.imgur.com/CEiBgSK.png',
                        fit: BoxFit.contain,
                        width: screenWidth * 0.6,
                      ),
                      // Imagem do Pokémon selecionado sobrepondo a Pokebola
                      Align(
                        alignment: Alignment(0.0, -0.2),
                        child: Image.network(
                          selectedPokemon.img,
                          fit: BoxFit.contain,
                          width: screenWidth * 0.25,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Texto de evolução
                Container(
                  width: screenWidth * 0.7,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [Colors.black, Colors.black],
                        stops: [1.0, 1.0],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'PARABÉNS, VOCÊ EVOLUIU SEU ${selectedPokemon.name.toUpperCase()}!',
                      style: GoogleFonts.bungeeHairline(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Botão para verificar última evolução
                Container(
                  width: screenWidth * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 22, 255, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ThankYouScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'ULTIMA EVOLUÇÃO!',
                      style: GoogleFonts.bungeeHairline(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Botão para selecionar outro Pokémon
                Container(
                  width: screenWidth * 0.7,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 224, 255, 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectPokemonScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'SELECIONAR OUTRO',
                      style: GoogleFonts.bungeeHairline(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          // Botão de voltar
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
