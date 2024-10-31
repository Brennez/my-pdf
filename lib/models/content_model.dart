import 'dart:io';

class ContentModel {
  ContentModel({
    this.thumbnailPath,
    this.updatedAt,
    this.createdAt,
    this.contentFilePath,
    required this.name,
    required this.description,
  });

  String? contentFilePath;
  String? thumbnailPath;
  String name;
  String description;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      thumbnailPath: map['thumbnailPath'],
      updatedAt: map['updatedAt'],
      contentFilePath: map['contentFilePath'],
      name: map['name'],
      description: map['description'],
      createdAt: map['createdAt'],
    );
  }
}
