import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokewalker/bloc/auth_bloc.dart';
import 'package:pokewalker/bloc/manage_bloc.dart';
import 'package:pokewalker/screens/landing_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //TODO move to a .env file
      options: const FirebaseOptions(
          apiKey: "AIzaSyD2nIBasM0-KawpdX0Zq4Uv630vDXbwSLU",
          authDomain: "pokewalker-ee834.firebaseapp.com",
          databaseURL: "https://pokewalker-ee834-default-rtdb.firebaseio.com",
          projectId: "pokewalker-ee834",
          storageBucket: "pokewalker-ee834.firebasestorage.app",
          messagingSenderId: "730096527444",
          appId: "1:730096527444:web:57d9c89f2ffab33146a5c1"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ManageBloc(InsertState(pokemons: []))
              ..add(
                GetPokemonListEvent(),
              );
          },
        ),
        BlocProvider(
          create: (context) {
            return AuthBloc();
          },
        )
      ],
      child: MaterialApp(
        title: 'Pokewalker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: LandingPageScreen(),
        ),
      ),
    );
  }
}
