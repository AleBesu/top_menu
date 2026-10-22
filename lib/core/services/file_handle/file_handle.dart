import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';

abstract class FilesHandle {
  static Future<FileImage?> pickerImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return FileImage(File(image.path));
  }
}
