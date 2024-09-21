import 'package:flutter/material.dart';
import 'package:pokewalker/screens/pokevolution_screen.dart';
import 'package:pokewalker/screens/pokewalker_screen.dart';

class PokemonItem extends StatelessWidget {
  final Map<String, String> pokemon;

  final double kilometersToNextLevel;

  PokemonItem({required this.pokemon, required this.kilometersToNextLevel});

  bool shouldEvolve() {
    return double.tryParse(pokemon['kilometers']!) == kilometersToNextLevel;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ação ao clicar no Pokémon
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            if (shouldEvolve()) {
              return PokevolutionScreen(
                selectedPokemon: pokemon, // Passa o Pokémon selecionado
              );
            } else {
              return PokewalkerScreen(
                selectedPokemon: pokemon,
                kilometersToNextLevel: kilometersToNextLevel,
                // Passa o Pokémon selecionado
              );
            }
          }),
        );
      },
      child: Card(
        elevation: 4,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                pokemon['img']!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Text(
                pokemon['name']!,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                pokemon['level']!,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
