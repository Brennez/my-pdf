import 'package:firebase_auth/firebase_auth.dart';
import 'package:maths_language/controllers/register_with_firebase.dart';
import 'package:maths_language/models/user_model.dart';
import 'package:maths_language/stores/global_stores/global_store.dart';
import 'package:maths_language/utils/firebase_auth_errors.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  RegisterWithFirebase authenticateWithFirebase = RegisterWithFirebase();
  final _globalStore = GlobalStoreBase();

  @observable
  String? errorMessage;

  @observable
  bool isLoading = false;

  @observable
  bool isRegister = false;

  @action
  void toogleAuthMethod() {
    isRegister = !isRegister;
  }

  @action
  Future<void> registerWithEmailAndPassword(UserModel user) async {
    try {
      isLoading = true;
      User? firebaseUser = await authenticateWithFirebase.register(user);
      _globalStore.setCurrentUser(user.fromFirabaseUser(firebaseUser));
      isLoading = false;
    } on FirebaseAuthErrors catch (e) {
      isLoading = false;
      errorMessage = e.getErrorName();
    }
  }

  @action
  Future<void> loginWithEmailAndPassword(UserModel user) async {
    try {
      isLoading = true;
      User? firebaseUser = await authenticateWithFirebase.login(user);
      _globalStore.setCurrentUser(user.fromFirabaseUser(firebaseUser));
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> logout() async {
    try {
      isLoading = true;
      await authenticateWithFirebase.logout();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }

  @action
  Future<User?> getLoggedUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return authenticateWithFirebase.getCurrentuser();
  }
}
