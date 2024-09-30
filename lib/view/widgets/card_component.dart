import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/content_model.dart';

class CardComponent extends StatelessWidget {
  final ContentModel content;

  const CardComponent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed("/edit", arguments: {
        "title": content.name,
        "date": content.updatedAt,
        "imagePath": content.thumbnailPath,
        "description": content.description,
        "file": content.contentFile,
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          elevation: 1,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    opacity: const AlwaysStoppedAnimation(.8),
                    content.thumbnailPath ??
                        "", //TODO: colocar uma imagem default aqui caso o campo venha null
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  content.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  "Editado em: ${content.updatedAt}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
