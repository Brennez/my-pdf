import 'dart:io';

class ContentModel {
  ContentModel({
    this.thumbnailPath,
    this.updatedAt,
    this.contentFilePath,
    required this.name,
    required this.description,
  });

  String? contentFilePath;
  String? thumbnailPath;
  String name;
  String description;
  DateTime? updatedAt;
}
