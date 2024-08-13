import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileHandler {
  File? _file;

  Future<File> getFile() async {
    try {
      PermissionStatus status = await Permission.storage.request();

      if (status.isGranted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          _file = File(result.files.single.path!);
        }
      } else {
        _file = File("");
      }
      return _file!;
    } catch (e) {
      rethrow;
    }
  }
}
