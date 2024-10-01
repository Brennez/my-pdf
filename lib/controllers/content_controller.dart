import 'dart:io';

import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/stores/global_stores/global_store.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentController {
  final _globalStore = GlobalStoreBase();

  Future<List<dynamic>> fetchContents(int id) async {
    final List<ContentModel> mockContentList = [];
    return mockContentList;
  }

  Future<String?> uploadImageToStorage(File path, String extensionImage) async {
    try {
      Reference storageRef = FirebaseStorage.instance.ref().child(
          "contents/thumbnails/${_globalStore.currentUser!.id}/${DateTime.now().millisecondsSinceEpoch}.${extensionImage}");

      UploadTask uploadTask = storageRef.putFile(path);

      TaskSnapshot snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw FirebaseException(
          message: "Erro ao fazer upload de imagem",
          plugin: 'Firebase Estorage');
    }
  }
}
