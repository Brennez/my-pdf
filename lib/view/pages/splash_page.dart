import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maths_language/stores/authentication_stores/auth_store.dart';

import '../../controllers/file_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthStore _authStore = AuthStore();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handleNavigatePage(),
      builder: (context, snapshot) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> handleNavigatePage() async {
    bool hasLoggedUser = await _authStore.hasLoggedUser();

    if (hasLoggedUser) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/auth',
        (Route<dynamic> route) => false,
      );
    }
  }
}
