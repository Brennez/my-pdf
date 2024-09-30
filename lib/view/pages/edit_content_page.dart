import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/view/widgets/input_component.dart';

class EditContentPage extends StatelessWidget {
  final ContentModel content;

  const EditContentPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: content.name);
    TextEditingController descriptionController =
        TextEditingController(text: content.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleController.text,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      "Título",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              InputComponent(controller: titleController, hintText: "título"),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      "Descrição",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              InputComponent(
                controller: descriptionController,
                hintText: "Descrição",
                hasMaxLines: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      "Capa",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width * .88,
                  child: Image.network(
                    content.thumbnailPath!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: 34,
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Selecionar nova capa",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.grey),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 90,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Salvar alterações",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple.shade200),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
