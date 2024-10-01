import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/stores/authentication_stores/auth_store.dart';
import 'package:maths_language/stores/global_stores/global_store.dart';

import '../widgets/card_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalStoreBase _globalStore = GlobalStoreBase();
  final AuthStore _authStore = AuthStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple.shade200,
        title: Text(
          "Olá, ${_globalStore.currentUser?.name.split(" ").first ?? ""}",
          style: const TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      endDrawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 147, 129, 179),
            ),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Logout"),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    IconButton(
                        onPressed: () => logoutUser(_authStore, context),
                        icon: const Icon(
                          Icons.logout,
                        )),
                  ],
                ),
                const Divider()
              ],
            ),
          ),
        ],
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardComponent(
            content: ContentModel(
                name: "Meu conteúdo",
                description: "Uma descrição bacana",
                updatedAt: DateTime.now(),
                thumbnailPath:
                    "https://cdn.pixabay.com/photo/2021/07/18/04/43/laughing-kookaburra-6474620_1280.jpg",
                contentFile: File("coisa_bacana_pdf.pdf")),
          ),
          CardComponent(
            content: ContentModel(
                name: "Meu conteúdo",
                description: "Uma descrição bacana",
                updatedAt: DateTime.now(),
                contentFile: File("coisa_bacana_pdf.pdf")),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/create'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> logoutUser(AuthStore authStore, BuildContext context) async {
    await authStore.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/auth',
      (Route<dynamic> route) => false,
    );
  }
}
