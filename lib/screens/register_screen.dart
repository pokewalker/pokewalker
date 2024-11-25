import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokewalker/screens/auth_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

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
              child: Form(
                key: _formKey,
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
                    _buildTextField(
                      context,
                      'Usuário',
                      _userController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu usuário';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      context,
                      'Senha',
                      _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      context,
                      'Nome',
                      _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      context,
                      'E-mail',
                      _emailController,
                      validator: (value) {
                        if (value == null ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor, insira um e-mail válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

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
                        Expanded(
                          child: Text(
                            'Aceito os Termos de Uso',
                            style: GoogleFonts.bungeeHairline(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receber Notificações',
                          style: GoogleFonts.bungeeHairline(
                            textStyle: TextStyle(
                              fontSize: 20,
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
                          activeTrackColor: Color.fromRGBO(198, 33, 33, 1),
                          inactiveThumbColor: Color.fromRGBO(198, 33, 33, 1),
                          inactiveTrackColor: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Idade: ${_age.round()}',
                          style: GoogleFonts.bungeeHairline(
                            textStyle: TextStyle(
                              fontSize: 20,
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

                    // Botão de Cadastrar
                    Container(
                      width: screenWidth * 0.8,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              _termsAccepted) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              // Usuário criado com sucesso
                              print(
                                  "Usuário criado: ${userCredential.user!.email}");

                              var extraUserData = {
                                'name': _nameController.text,
                                'username': _userController.text,
                                'age': _age,
                                'receiveNotifications': _receiveNotifications
                              };

                              print(extraUserData);

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userCredential.user!.uid)
                                  .set(extraUserData);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Cadastro Concluído'),
                                    content:
                                        Text('Você se cadastrou com sucesso!'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                switch (e.code) {
                                  case 'weak-password':
                                    print('A senha fornecida é muito fraca.');
                                    break;
                                  case 'email-already-in-use':
                                    print('A conta já existe para esse email.');
                                    break;
                                  default:
                                    print('Erro desconhecido: ${e.message}');
                                }
                              } else {
                                print('Erro: ${e.toString()}');
                              }
                            }
                          } else if (!_termsAccepted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Você deve aceitar os Termos de Uso!',
                                ),
                              ),
                            );
                          }
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

  Widget _buildTextField(
    BuildContext context,
    String hint,
    TextEditingController controller, {
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.quicksand(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
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
        validator: validator,
      ),
    );
  }
}
