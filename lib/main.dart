import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:maths_language/controllers/content_controller.dart';
import 'package:maths_language/controllers/file_handler.dart';
import 'package:maths_language/view/pages/home_page.dart';
import 'package:maths_language/view/pages/splash_page.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_options.dart';
import 'view/pages/auth_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ContentController contentController = ContentController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    contentController.initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: Scaffold(
              body: handleInitialPage(snapshot),
            ),
          ),
        );
      },
    );
  }
}

Widget handleInitialPage(AsyncSnapshot<FirebaseApp> snapshot) {
  if (snapshot.connectionState == ConnectionState.done) {
    return const SplashPage();
  } else if (snapshot.hasError) {
    return const Center(
      child: Text("Um erro inesperado aconteceu"),
    );
  } else {
    return const Center(
      child: Text("Algo deu errado!"),
    );
  }
}
