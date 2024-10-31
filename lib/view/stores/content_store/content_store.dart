import 'dart:io';

import 'package:maths_language/controllers/content_controller.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/models/enums/file_type_enum.dart';
import 'package:mobx/mobx.dart';
part 'content_store.g.dart';

enum ScreenStatus { initial, loading, success, error }

class ContentStore = ContentStoreBase with _$ContentStore;

abstract class ContentStoreBase with Store {
  ContentController contentController = ContentController();

  @observable
  ScreenStatus status = ScreenStatus.initial;

  @observable
  String? errorMessage;

  @observable
  List<ContentModel> contentList = [];

  @action
  Future<String?> saveFileToStorage(
      File imageFile, FileTypeEnum fileType, String imageExtension) async {
    try {
      status = ScreenStatus.loading;
      final result = await contentController.uploadFileToStorage(
          imageFile, fileType, imageExtension);
      status = ScreenStatus.success;
      return result;
    } catch (e) {
      status = ScreenStatus.error;
      errorMessage = "Erro ao salvar arquivo";
      throw Exception(errorMessage);
    }
  }

  @action
  Future<void> saveContentToFirestore(ContentModel content) async {
    try {
      status = ScreenStatus.loading;
      await contentController.saveToFirestore(content);
      status = ScreenStatus.success;
    } catch (e) {
      status = ScreenStatus.error;
      errorMessage = "Erro ao salvar conteúdo";
      throw Exception(errorMessage);
    }
  }

  @action
  Future<List<ContentModel>> fetchContents() async {
    try {
      status = ScreenStatus.loading;
      final result = await contentController.getContentsFromFirestore();

      for (var element in result) {
        contentList.add(ContentModel.fromMap(element));
      }

      status = ScreenStatus.success;
      return contentList;
    } catch (e) {
      status = ScreenStatus.error;
      errorMessage = "Erro ao buscar conteúdos";
      throw Exception(errorMessage);
    }
  }
}
