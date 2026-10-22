import 'dart:io';

import 'package:path/path.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';

abstract class ServerHandle {
  Future<void> startServer();
  Future<void> stopServer();
  Future<void> restartServer();
  static HttpServer? _server;

  static Future<void> startWebServer({int port = 8080}) async {
    // 1. Leer el ZIP desde los assets.
    final ByteData data = await rootBundle.load('assets/web.zip');

    final Uint8List bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );

    // 2. Obtener un directorio escribible.
    final Directory appDir = await getApplicationDocumentsDirectory();

    final Directory webDir = Directory(join(appDir.path, 'web'));

    // 3. Limpiar la extracción anterior.
    if (await webDir.exists()) {
      await webDir.delete(recursive: true);
    }

    await webDir.create(recursive: true);

    // 4. Descomprimir el ZI
    final Archive archive = ZipDecoder().decodeBytes(bytes);

    for (final ArchiveFile file in archive.files) {
      final String outputPath = normalize(join(webDir.path, file.name));

      // Evitar rutas que escapen del directorio de destino.
      if (outputPath != webDir.path && !isWithin(webDir.path, outputPath)) {
        continue;
      }

      if (file.isDirectory) {
        await Directory(outputPath).create(recursive: true);
        continue;
      }

      final outputFile = File(outputPath);

      await outputFile.parent.create(recursive: true);

      await outputFile.writeAsBytes(file.content as List<int>, flush: true);
    }

    // 5. Crear el handler de archivos estáticos.
    final Handler handler = createStaticHandler(
      webDir.path,
      defaultDocument: 'index.html',
    );

    // 6. Iniciar el servidor HTT
    _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  }

  static Future<void> stopWebServer() async {
    final server = _server;

    if (server == null) return;

    await server.close(force: true);
    _server = null;
  }
}
