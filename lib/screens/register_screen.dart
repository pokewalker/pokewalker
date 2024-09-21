import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/screens/auth_screen.dart';
import 'package:pokewalker/screens/select_pokemon_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _termsAccepted = false;
  bool _receiveNotifications = true;
  double _age = 25;
  String? _gender;

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
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                      'INSIRA SEUS DADOS',
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
                  SizedBox(height: 30),
                  _buildTextField(context, 'Usuário'),
                  SizedBox(height: 20),
                  _buildTextField(context, 'Senha', obscureText: true),
                  SizedBox(height: 20),
                  _buildTextField(context, 'Nome'),
                  SizedBox(height: 20),
                  _buildTextField(context, 'E-mail'),
                  SizedBox(height: 20),

                  // Checkbox para Termos de Uso
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (bool? value) {
                          setState(() {
                            _termsAccepted = value ?? false;
                          });
                        },
                        activeColor: Color.fromRGBO(198, 33, 33, 1),
                      ),
                      Text(
                        'Aceito os Termos de Uso',
                        style: GoogleFonts.bungeeHairline(
                          textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Switch para receber notificações
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Receber Notificações',
                        style: GoogleFonts.bungeeHairline(
                          textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Switch(
                          value: _receiveNotifications,
                          onChanged: (bool value) {
                            setState(() {
                              _receiveNotifications = value;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Color.fromRGBO(
                              198, 33, 33, 1), // Cor quando ativado
                          inactiveThumbColor: Color.fromRGBO(
                              198, 33, 33, 1), // Cor do botão quando desativado
                          inactiveTrackColor:
                              Colors.white // Cor da faixa quando desativado
                          ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Slider para escolher a idade
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Idade: ${_age.round()}',
                        style: GoogleFonts.bungeeHairline(
                          textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Slider(
                        value: _age,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: _age.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _age = value;
                          });
                        },
                        activeColor: Color.fromRGBO(198, 33, 33, 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // RadioButtons para seleção de gênero
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gênero:',
                        style: GoogleFonts.bungeeHairline(
                          textStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 'masculino',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value as String?;
                                  });
                                },
                                activeColor: Color.fromRGBO(198, 33, 33, 1),
                              ),
                              Text(
                                'Masculino',
                                style: GoogleFonts.bungeeHairline(
                                  textStyle: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'feminino',
                                groupValue: _gender,
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value as String?;
                                  });
                                },
                                activeColor: Color.fromRGBO(198, 33, 33, 1),
                              ),
                              Text(
                                'Feminino',
                                style: GoogleFonts.bungeeHairline(
                                  textStyle: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  // Botão de Cadastrar
                  Container(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        // Exibir popup de confirmação
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Cadastro Concluído'),
                              content: Text('Você se cadastrou com sucesso!'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Fechar o popup
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => AuthScreen(),
                                      ),
                                    ); // Navegar para a tela de login
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(107, 107, 107, 1),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Cadastrar',
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
          ),
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

  Widget _buildTextField(BuildContext context, String hint,
      {bool obscureText = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        obscureText: obscureText,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.quicksand(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.grey[600],
            ),
          ),
          filled: true,
          fillColor: Colors.grey[400],
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
