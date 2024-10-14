import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/models/enums/file_type_enum.dart';
import 'package:maths_language/stores/global_stores/global_store.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContentController {
  final _globalStore = GlobalStoreBase();

  Future<List<dynamic>> fetchContents(int id) async {
    final List<ContentModel> mockContentList = [];
    return mockContentList;
  }

  Future<String?> uploadFileToStorage(
      File file, FileTypeEnum fileType, String fileExtension) async {
    UploadTask uploadTask;
    String? contentUrl;

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(fileType == FileType.image ? 'thumbnails' : 'contents')
          .child('/${DateTime.now().millisecondsSinceEpoch}.$fileExtension');

      final metadata = SettableMetadata(
        contentType: '$fileType',
        customMetadata: {'picked-file-path': file.path},
      );

      uploadTask = ref.putFile(File(file.path), metadata);

      await uploadTask.whenComplete(() async {
        try {
          contentUrl = await ref.getDownloadURL();
        } on FirebaseException catch (e) {
          Exception("Erro ao recuperar URL do arquivo ${e.toString()}");
        }
      });
      return contentUrl;
    } on FirebaseException catch (e) {
      Exception("Erro ao fazer upload do arquivo ${e.toString()}");
    }
    return null;
  }

  Future<void> saveToFirestore(ContentModel content) async {
    try {
      await FirebaseFirestore.instance.collection("contents").add({
        "name": content.name,
        "description": content.description,
        "thumbnailPath": content.thumbnailPath,
        "contentFile": content.contentFilePath,
        "updatedAt": content.updatedAt,
        "userId": _globalStore.currentUser!.id,
      });
    } catch (e) {
      throw FirebaseException(
          message: "Erro ao salvar conteúdo", plugin: 'Firestore');
    }
  }
}
