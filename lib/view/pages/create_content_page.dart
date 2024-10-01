import 'dart:io';

import 'package:flutter/material.dart';

import '../../utils/file_manager_utils/custom_file_manager.dart';
import '../widgets/input_component.dart';

class CreateContentPage extends StatefulWidget {
  const CreateContentPage({super.key});

  @override
  State<CreateContentPage> createState() => _CreateContentPageState();
}

class _CreateContentPageState extends State<CreateContentPage> {
  @override
  Widget build(BuildContext context) {
    CustomFileManager fileManager = CustomFileManager();
    File? _selectedImage;

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    Future<void> _selectImage() async {
      File? image = await fileManager.pickImageFile();

      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
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
                    child: Image.asset(
                      _selectedImage!.path,
                      fit: BoxFit.fill,
                    )),
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
