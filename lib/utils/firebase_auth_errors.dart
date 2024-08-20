import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrors implements Exception {
  String message;

  FirebaseAuthErrors({
    required this.message,
  });

  String getErrorName() {
    switch (message) {
      case "invalid-email":
        return "E-mail inválido";
      case "user-disabled":
        return "A conta deste usuário foi desativada";
      case "user-not-found":
        return "Usuário não encontrado";
      case "wrong-password":
        return "Senha incorreta";
      case "email-already-in-use":
        return "O email fornecido já está em uso";

      default:
        return "Erro desconhecido ocorreu ao tentar logar no app";
    }
  }
}
