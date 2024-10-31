// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContentStore on ContentStoreBase, Store {
  late final _$statusAtom =
      Atom(name: 'ContentStoreBase.status', context: context);

  @override
  ScreenStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(ScreenStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'ContentStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$contentListAtom =
      Atom(name: 'ContentStoreBase.contentList', context: context);

  @override
  List<ContentModel> get contentList {
    _$contentListAtom.reportRead();
    return super.contentList;
  }

  @override
  set contentList(List<ContentModel> value) {
    _$contentListAtom.reportWrite(value, super.contentList, () {
      super.contentList = value;
    });
  }

  late final _$saveFileToStorageAsyncAction =
      AsyncAction('ContentStoreBase.saveFileToStorage', context: context);

  @override
  Future<String?> saveFileToStorage(
      File imageFile, FileTypeEnum fileType, String imageExtension) {
    return _$saveFileToStorageAsyncAction.run(
        () => super.saveFileToStorage(imageFile, fileType, imageExtension));
  }

  late final _$saveContentToFirestoreAsyncAction =
      AsyncAction('ContentStoreBase.saveContentToFirestore', context: context);

  @override
  Future<void> saveContentToFirestore(ContentModel content) {
    return _$saveContentToFirestoreAsyncAction
        .run(() => super.saveContentToFirestore(content));
  }

  late final _$fetchContentsAsyncAction =
      AsyncAction('ContentStoreBase.fetchContents', context: context);

  @override
  Future<List<ContentModel>> fetchContents() {
    return _$fetchContentsAsyncAction.run(() => super.fetchContents());
  }

  @override
  String toString() {
    return '''
status: ${status},
errorMessage: ${errorMessage},
contentList: ${contentList}
    ''';
  }
}
