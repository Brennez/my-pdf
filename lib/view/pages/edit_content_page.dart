import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/utils/file_manager_utils/custom_file_manager.dart';
import 'package:maths_language/view/widgets/input_component.dart';

class EditContentPage extends StatefulWidget {
  final ContentModel content;

  const EditContentPage({super.key, required this.content});

  @override
  State<EditContentPage> createState() => _EditContentPageState();
}

class _EditContentPageState extends State<EditContentPage> {
  CustomFileManager fileManager = CustomFileManager();

  Future<void> _selectImage() async {
    File? image = await fileManager.pickImageFile();

    if (image != null) {
      setState(() {
        widget.content.thumbnailPath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String defaultThumb = 'assets/images/default_folder.png';

    TextEditingController titleController =
        TextEditingController(text: widget.content.name);

    TextEditingController descriptionController =
        TextEditingController(text: widget.content.description);

    Widget _getImageType() {
      if (widget.content.thumbnailPath == null) {
        return Image.asset(
          'assets/images/default_folder.png',
          fit: BoxFit.fill,
        );
      }

      return Image.network(widget.content.thumbnailPath!);
    }

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
                  child: _getImageType(),
                ),
              ),
              Container(
                height: 34,
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _selectImage(),
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.black54,
                      ),
                      label: const Text(
                        "Selecionar nova capa",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.grey[200]),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          )),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      "Conteúdo",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 206, 196, 224),
                  borderRadius: BorderRadius.circular(10), // Borda arredondada
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(widget.content.contentFile == null
                      ? "Adicione um arquivo"
                      : widget.content.contentFile!.path),
                ),
              ),
              Container(
                width: double.infinity,
                height: 90,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple.shade200),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      )),
                  child: const Text(
                    "Salvar alterações",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
