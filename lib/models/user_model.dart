import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String? password;

  UserModel({
    this.id,
    this.password,
    required this.name,
    required this.email,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(name: user.displayName!, email: user.email!, id: user.uid);
  }
}
