import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> appLocalImagesfolderPath() async {
  return "${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}images";
}
