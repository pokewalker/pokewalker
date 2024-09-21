import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokewalker/screens/autenticate_screen.dart';
import 'package:pokewalker/screens/landing_page_screen.dart';
import 'package:pokewalker/screens/select_pokemon_screen.dart';
import 'package:pokewalker/screens/thank_you_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SelectPokemonScreen(),
        // body: LandingPageScreen(),
        // body: ThankYouScreen(),
      ),
    );
  }
}
