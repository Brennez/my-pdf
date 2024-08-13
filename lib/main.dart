import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:maths_language/controllers/file_handler.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _version = 'Unknown';
  FileHandler file = FileHandler();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize via an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize();
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.""
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  openFile(String path) async {
    startDocumentLoadedListener((filePath) {
      print("document loaded: $filePath");
    });

    await PdftronFlutter.openDocument(path);
  }

  getContent() async {
    File filePath = await file.getFile();
    if (filePath.path.isNotEmpty) {
      openFile(filePath.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Teste'),
          centerTitle: true,
        ),
        body: Center(
          child: TextButton(
            child: Text("Abrir conteúdo"),
            onPressed: getContent,
          ),
        ),
      ),
    );
  }
}
