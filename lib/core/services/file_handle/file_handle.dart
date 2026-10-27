import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_menu/core/const/app_local_images_path.dart';

abstract class FilesManagerService {
  static Future<FileImage?> pickerImage({
    ImageSource source = ImageSource.gallery,
    bool copyToAppDirectory = true,
    bool cropImage = true,
    CropAspectRatio? aspectRatio,
  }) async {
    final imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
      source: source,
      maxHeight: 720,
      maxWidth: 1280,
    );

    if (image != null) {
      if (cropImage) {
        //crop image
        final imageCropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: aspectRatio,
        );
        //if croped image != null then set new value to "image"
        if (imageCropped != null) {
          image = XFile(imageCropped.path);
        }
      }

      //if copyToAppDirectory is true, save the image in app documents directory and return the FileImage
      //of the saved image
      if (copyToAppDirectory) {
        return await saveImageInAppDirectory(File(image.path));
      } else {
        //return the FileImage of the picked image
        return FileImage(File(image.path));
      }
    }

    //if no image was picked, return null
    return null;
  }

  static Future<FileImage> saveImageInAppDirectory(File sourceFile) async {
    final imagesDir = Directory(await appLocalImagesfolderPath());

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    final fileExtension = sourceFile.uri.pathSegments.last.split('.').last;

    final destinationFile = File(
      '${imagesDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension',
    );

    return FileImage(await sourceFile.copy(destinationFile.path));
  }
}
