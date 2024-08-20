import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maths_language/stores/authentication_stores/auth_store.dart';
import 'package:maths_language/view/pages/auth_page.dart';
import 'package:maths_language/view/pages/home_page.dart';

import '../../controllers/content_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthStore _authStore = AuthStore();
  ContentController contentController = ContentController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handleNavigatePage(),
      builder: (context, snapshot) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<void> handleNavigatePage() async {
    User? loggedUser = await _authStore.getLoggedUser();

    if (loggedUser != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AuthenticationPage(),
        ),
      );
    }
  }
}
