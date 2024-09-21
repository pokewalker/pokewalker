import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokewalkerScreen extends StatelessWidget {
  const PokewalkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela para garantir o design responsivo
    double screenWidth = MediaQuery.of(context).size.width;

    // Define a porcentagem do progresso
    double progressPercentage = 0.4; // Exemplo: 40% de progresso

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
                        'https://i.imgur.com/CEiBgSK.png', // Substitua pelo link direto da sua imagem
                        fit: BoxFit.contain,
                        width: screenWidth * 0.6,
                      ),
                      // Imagem do Pokémon sobrepondo a Pokebola
                      Align(
                        alignment: Alignment(0.0, -0.2),
                        child: Image.network(
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png', // Link para a imagem do Pokémon
                          fit: BoxFit.contain,
                          width: screenWidth * 0.25,
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
                      '1500 METROS',
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
                      '9 KM RESTANTES',
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
