import 'dart:io';

import 'package:file_picker/file_picker.dart';

class CustomFileManager {
  Future<File?> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      // Obtém o caminho do arquivo selecionado
      String? filePath = result.files.single.path;
      if (filePath != null) {
        // Retorna o arquivo selecionado
        return File(filePath);
      }
    }
    return null;
  }
}
