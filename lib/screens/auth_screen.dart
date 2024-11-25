import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/bloc/auth_bloc.dart';
import 'package:pokewalker/screens/select_pokemon_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String login = "";
  String senha = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Obtém a largura da tela
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
                const SizedBox(height: 30),

                // Formulário
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo de Login
                      Container(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.grey[600],
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[400],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSaved: (String? newValue) {
                            login = newValue ?? "";
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Erro: Insira seu login";
                            } else if (value.length < 3) {
                              return "Erro: Login deve ter no mínimo 3 caracteres";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo de Senha
                      Container(
                        width: screenWidth * 0.8,
                        child: TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            hintStyle: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.grey[600],
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[400],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSaved: (String? newValue) {
                            senha = newValue ?? "";
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Erro: Insira sua senha";
                            } else if (value.length < 3) {
                              return "Erro: Senha deve ter no mínimo 3 caracteres";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Botão de Login
                Container(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        BlocProvider.of<AuthBloc>(context).add(LoginUser(
                          email: login,
                          password: senha,
                        ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Login efetuado com sucesso!',
                            ),
                          ),
                        );

                        if (BlocProvider.of<AuthBloc>(context).state
                            is Authenticated) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SelectPokemonScreen(),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(198, 33, 33, 1),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
