import 'package:maths_language/models/user_model.dart';
import 'package:mobx/mobx.dart';
part 'global_store.g.dart';

class GlobalStore = GlobalStoreBase with _$GlobalStore;

abstract class GlobalStoreBase with Store {
  GlobalStoreBase._privateConstructor();

  static final GlobalStore _instance = GlobalStore._privateConstructor();

  factory GlobalStoreBase() {
    return _instance;
  }

  @observable
  UserModel? currentUser;

  @action
  void setCurrentUser(UserModel user) {
    currentUser = user;
  }
}
