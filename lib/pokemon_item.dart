import 'package:flutter/material.dart';

class PokemonItem extends StatelessWidget {
  final Map<String, String> pokemon;

  PokemonItem({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ação ao clicar no Pokémon
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Você clicou no ${pokemon['name']}!'),
            );
          },
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
