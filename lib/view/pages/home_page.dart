import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/view/stores/authentication_stores/auth_store.dart';
import 'package:maths_language/view/stores/content_store/content_store.dart';
import 'package:maths_language/view/stores/global_stores/global_store.dart';

import '../widgets/card_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalStoreBase _globalStore = GlobalStoreBase();
  final AuthStore _authStore = AuthStore();

  final ContentStore _contentStore = ContentStore();

  @override
  void initState() {
    super.initState();
    _contentStore.fetchContents();
  }

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
      body: Observer(
        builder: (context) {
          if (_contentStore.status == ScreenStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_contentStore.contentList.isEmpty) {
            return const Center(
              child: Text("Nenhum conteúdo encontrado"),
            );
          }

          return ListView.builder(
            itemCount: _contentStore.contentList.length,
            itemBuilder: (context, index) {
              ContentModel content = _contentStore.contentList[index];
              return CardComponent(
                content: content,
              );
            },
          );
        },
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
