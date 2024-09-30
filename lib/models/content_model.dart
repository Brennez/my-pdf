import 'dart:io';

class ContentModel {
  ContentModel({
    this.thumbnailPath,
    required this.name,
    required this.description,
    required this.updatedAt,
    this.contentFile,
  });

  File? contentFile;
  String? thumbnailPath;
  String name;
  String description;
  DateTime updatedAt;
}
