import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Unauthenticated()) {
    on<RegisterUser>(
        (RegisterUser event, Emitter emit) {}); //TODO emit Authenticated

    // Evento de login
    on<LoginUser>((LoginUser event, Emitter<AuthState> emit) async {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        emit(Authenticated(email: userCredential.user?.email ?? 'Usuário'));
      } catch (e) {
        emit(AuthError(
            message:
                'Falha no login: ${e is FirebaseAuthException ? e.message : e.toString()}'));
      }
    });

    // Evento de logout
    on<Logout>((Logout event, Emitter<AuthState> emit) async {
      await FirebaseAuth.instance.signOut();
      emit(Unauthenticated());
    });
  }
}

/*
 Eventos
*/
abstract class AuthEvent {}

class LoginUser extends AuthEvent {
  String email;
  String password;

  LoginUser({required this.email, required this.password});
}

class RegisterUser extends AuthEvent {
  String username;
  String password;
  String nome;
  String email;
  bool acceptTerms;
  bool allowNotifications;
  int age;
  String gender;

  RegisterUser(
      {required this.username,
      required this.password,
      required this.nome,
      required this.email,
      required this.acceptTerms,
      required this.allowNotifications,
      required this.age,
      required this.gender});
}

class Logout extends AuthEvent {}

/*
Estados
*/
abstract class AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  String email;
  Authenticated({required this.email});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
