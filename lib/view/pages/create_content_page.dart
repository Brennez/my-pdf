import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maths_language/models/content_model.dart';
import 'package:maths_language/view/stores/content_store/content_store.dart';

import '../../models/enums/file_type_enum.dart';
import '../../utils/constants/default_thumb.dart';
import '../../utils/file_manager_utils/custom_file_manager.dart';
import '../widgets/input_component.dart';

class CreateContentPage extends StatefulWidget {
  const CreateContentPage({super.key});

  @override
  State<CreateContentPage> createState() => _CreateContentPageState();
}

class _CreateContentPageState extends State<CreateContentPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ContentStore _contentStore = ContentStore();

  CustomFileManager fileManager = CustomFileManager();
  XFile? _selectedImage;
  File? _selectedFile;
  String? _imageUrl;
  String? _fileUrl;

  Future<void> _selectContent(FileTypeEnum type) async {
    if (type == FileTypeEnum.thumbnail) {
      XFile? image = await fileManager.pickImage();
      setState(
          () => image != null ? _selectedImage = image : _selectedImage = null);
    } else {
      File? file = await fileManager.pickContentFile();
      setState(
          () => file != null ? _selectedFile = file : _selectedFile = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Criar conteúdo",
          style: TextStyle(color: Colors.white),
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
              InputComponent(controller: _titleController, hintText: "título"),
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
                controller: _descriptionController,
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
              GestureDetector(
                onTap: () async {
                  await pickAndUploadContent(FileTypeEnum.thumbnail);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width * .88,
                    child: _selectedImage == null
                        ? Image.asset(
                            defaultThumb,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            File(_selectedImage!.path),
                            fit: BoxFit.fill,
                          ),
                  ),
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
              GestureDetector(
                onTap: () async {
                  await pickAndUploadContent(FileTypeEnum.content);
                },
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 196, 224),
                    borderRadius:
                        BorderRadius.circular(10), // Borda arredondada
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(_selectedFile == null
                              ? "Selecione um arquivo"
                              : _selectedFile!.uri.pathSegments.last),
                        ),
                        const Expanded(child: SizedBox()),
                        const Icon(
                          Icons.upload,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 90,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                    onPressed: () => _saveContent(_contentStore),
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.deepPurple.shade200),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        )),
                    child: Observer(
                      builder: (context) {
                        return _contentStore.status == ScreenStatus.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                "Salvar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickAndUploadContent(FileTypeEnum fileType) async {
    if (fileType == FileTypeEnum.content) {
      await _selectContent(FileTypeEnum.content);
      await _contentStore
          .saveFileToStorage(File(_selectedFile!.path), FileTypeEnum.content,
              _selectedFile!.path.split('.').last)
          .then((value) {
        setState(() {
          _fileUrl = value;
        });
      });
    }

    if (fileType == FileTypeEnum.thumbnail) {
      await _selectContent(FileTypeEnum.thumbnail);
      await _contentStore
          .saveFileToStorage(File(_selectedImage!.path), FileTypeEnum.thumbnail,
              _selectedImage!.path.split('.').last)
          .then((value) {
        setState(() {
          _imageUrl = value;
        });
      });
    }
  }

  _saveContent(ContentStore contentStore) async {
    await contentStore.saveContentToFirestore(ContentModel(
      name: _titleController.text,
      description: _descriptionController.text,
      thumbnailPath: _imageUrl,
      contentFilePath: _fileUrl,
      createdAt: DateTime.now(),
    ));

    Navigator.of(context).pop();
  }
}
