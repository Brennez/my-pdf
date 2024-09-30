import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maths_language/models/user_model.dart';
import 'package:maths_language/stores/global_stores/global_store.dart';
import 'package:maths_language/view/pages/home_page.dart';

import '../../stores/authentication_stores/auth_store.dart';
import '../widgets/input_component.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthStore authStore = AuthStore();

    return Scaffold(
      body: Observer(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(authStore.isRegister ? "Cadastro" : "Login"),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: authStore.isRegister,
                child: InputComponent(
                  controller: _nameController,
                  hintText: "nome",
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InputComponent(
                controller: _emailController,
                hintText: "e-mail",
                isPassword: false,
              ),
              const SizedBox(
                height: 10,
              ),
              InputComponent(
                controller: _passwordController,
                hintText: "senha",
                isPassword: true,
              ),
              Row(
                children: [
                  Observer(builder: (context) {
                    return TextButton(
                      onPressed: () {
                        authStore.toogleAuthMethod();
                      },
                      child: Text(
                        authStore.isRegister
                            ? "Já possuo uma conta"
                            : "Fazer cadastro",
                        style: const TextStyle(fontSize: 13),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 20)),
                  onPressed: () async {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    await authentication(
                        UserModel(name: name, email: email, password: password),
                        authStore);

                    if (authStore.errorMessage != null) {
                      showErrorDialog(context, authStore);
                    }
                    navigateToHomePage(context);
                  },
                  child: authStore.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

Future<void> showErrorDialog(BuildContext context, AuthStore authStore) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("oops!"),
        content: Text(authStore.errorMessage!),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

void navigateToHomePage(BuildContext context) {
  bool isLoggedWithSuccess =
      GlobalStoreBase().currentUser != null ? true : false;
  if (isLoggedWithSuccess) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }
}

Future<void> authentication(UserModel user, AuthStore authStore) async {
  if (authStore.isRegister) {
    await authStore.registerWithEmailAndPassword(user);
  } else {
    await authStore.loginWithEmailAndPassword(user);
  }
}
