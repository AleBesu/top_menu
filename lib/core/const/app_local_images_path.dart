import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> appLocalImagesfolderPath() async {
  final imagesDirectory = Directory(
    "${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}images",
  );

  if (!await imagesDirectory.exists()) {
    await imagesDirectory.create(recursive: true);
  }
  return imagesDirectory.path;
}
