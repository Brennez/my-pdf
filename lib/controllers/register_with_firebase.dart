import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../utils/firebase_auth_errors.dart';

class RegisterWithFirebase {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> register(UserModel user) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: user.password!);

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(user.name);
      }
      User loggedUser = _firebaseAuth.currentUser!;

      await usersCollection.add({
        "uid": loggedUser.uid,
        "name": loggedUser.displayName,
        "email": loggedUser.email,
      });

      return loggedUser;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrors(message: e.code);
    }
  }

  Future<User> login(UserModel user) async {
    User? loggedUser;

    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: user.email, password: user.password!);
      if (userCredential.user != null) {
        loggedUser = userCredential.user!;
      }
      return loggedUser!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthErrors(message: e.code);
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentuser() {
    return _firebaseAuth.currentUser;
  }
}
