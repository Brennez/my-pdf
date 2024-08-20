import 'dart:io';

import 'package:flutter/services.dart';
import 'package:maths_language/controllers/file_handler.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

class ContentController {
  FileHandler fileHandler = FileHandler();

  // Platform messages are asynchronous, so we initialize via an async method.
  Future<String> initPlatformState() async {
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
    // if (!mounted) return;

    // setState(() {
    //   _version = version;
    // });
    return version;
  }

  Future<void> openFile(String path) async {
    startDocumentLoadedListener((filePath) {
      print("document loaded: $filePath");
    });

    await PdftronFlutter.openDocument(path);
  }

  getContent() async {
    File filePath = await fileHandler.getFile();
    if (filePath.path.isNotEmpty) {
      openFile(filePath.path);
    }
  }
}
