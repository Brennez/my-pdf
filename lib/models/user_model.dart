import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String? password;

  UserModel({
    required this.name,
    required this.email,
    this.password,
  });

  UserModel fromFirabaseUser(User user) {
    return UserModel(name: user.displayName!, email: user.email!);
  }
}
