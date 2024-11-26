import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/model/pokemon.dart';

class PokewalkerScreen extends StatelessWidget {
  final Pokemon selectedPokemon;

  const PokewalkerScreen({super.key, required this.selectedPokemon});

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela para garantir o design responsivo
    double screenWidth = MediaQuery.of(context).size.width;

    int metersWalked = selectedPokemon.meters;
    int metersToNextLevel = selectedPokemon.metersToNextLevel;

    double progressPercentage = metersWalked / metersToNextLevel;

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

                // Imagem da Pokebola com o Pokémon selecionado
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
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/pokemon-image-not-found.png', // Caminho da imagem padrão
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Botão 1 (Distância percorrida)
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
                        colors: [Colors.black, Colors.black], // Cor da borda
                        stops: [1.0, 1.0], // Define o contorno
                      ).createShader(bounds);
                    },
                    child: Text(
                      '$metersWalked METROS',
                      style: GoogleFonts.bungeeHairline(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Cor do texto
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),

// Botão 2 (Distância restante)
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
                        colors: [Colors.black, Colors.black], // Cor da borda
                        stops: [1.0, 1.0], // Define o contorno
                      ).createShader(bounds);
                    },
                    child: Text(
                      '${metersToNextLevel - metersWalked} METROS RESTANTES',
                      style: GoogleFonts.bungeeHairline(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Cor do texto
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Barra de progresso com o Pokémon correndo
                Stack(
                  children: [
                    // Fundo da barra de progresso
                    Container(
                      width: screenWidth * 0.7,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    // Barra preenchida
                    Container(
                      width: screenWidth * 0.7 * progressPercentage,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                    // Imagem do Ponyta na barra de progresso
                    Positioned(
                      left: screenWidth * 0.7 * progressPercentage -
                          35, // Posiciona conforme o progresso
                      top: -10, // Ajuste para posicionar sobre a barra
                      child: Image.network(
                        'https://i.imgur.com/ljERCcz.jpg', // Imagem do Ponyta
                        width: 60,
                        height: 60,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // Lógica de andar
                          // Atualiza a distância percorrida
                          // Atualiza o nível do Pokémon
                        },
                        child: Text('Andar')),
                  ],
                ),
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
                // Lógica de voltar
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
