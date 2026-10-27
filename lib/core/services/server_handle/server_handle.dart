import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:path/path.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as r;
import 'package:shelf_static/shelf_static.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';
import 'package:top_menu/UI/providers/ui_providers.dart';
import 'package:top_menu/core/const/app_local_images_path.dart';
import 'package:top_menu/core/extensions/color.dart';

abstract class ServerHandle {
  //==========================SERVER HANDLE==========================
  static HttpServer? _server;

  static Future<void> init({required WidgetRef ref}) async {
    try {
      final webHandler = await startWebServer();
      final apiServerHandler = await startApiServer(ref: ref);

      final handler = Cascade().add(webHandler).add(apiServerHandler).handler;

      // 6. Iniciar el servidor HTT
      _server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> stopServer() async {
    final server = _server;

    if (server == null) return;

    await server.close(force: true);
    _server = null;
  }

  ///==========================WEB SERVER==========================

  static Future<Handler> startWebServer() async {
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
    Handler handler = createStaticHandler(
      webDir.path,
      defaultDocument: 'index.html',
    );

    return handler;
  }

  //==========================API SERVER==========================

  static Future<Handler> startApiServer({required WidgetRef ref}) async {
    r.Router router = r.Router();

    final restauranteConfigPro = ref.read(menuConfigProvider);
    // final viewModePro = ref.read(viewModeProvider).name;

    String? bannerUrl = restauranteConfigPro.bannerPath == null
        ? null
        : await _getLocalImageUrl(restauranteConfigPro.bannerPath!);

    router.get('/get-menu-config', (Request req) {
      return Response.ok(
        jsonEncode({
          "name": restauranteConfigPro.name,
          "bannerUrl": bannerUrl,
          "openTime": restauranteConfigPro.openTime,
          "closeTime": restauranteConfigPro.closeTime,
          'address': restauranteConfigPro.address,
          'isDarkTheme': restauranteConfigPro.isDarkTheme,
          'numberPhone': restauranteConfigPro.numberPhone,
          'primaryColor': restauranteConfigPro.primaryColor.toJson(),
          'menuLayoutMode': restauranteConfigPro.menuLayoutMode.name,
        }),
      );
    });

    //set Url image to products
    for (var category in restauranteConfigPro.categories) {
      for (var product in category.products) {
        product.imageUrl = product.imagePath != null
            ? await _getLocalImageUrl(product.imagePath!)
            : null;
      }
    }

    router.get('/fetch-categories-list', (Request req) {
      return Response.ok(
        jsonEncode(
          restauranteConfigPro.categories.map((e) => e.toJson()).toList(),
        ),
      );
    });

    router.mount(
      '/images/',
      createStaticHandler(await appLocalImagesfolderPath()),
    );

    return router;
  }

  static Future<String> _getLocalImageUrl(String imagePath) async {
    try {
      final ip = await NetworkInfo().getWifiIP();

      // final imageFileName = imagePath.split('/').last;

      final imageFileName = basename(imagePath);

      return 'http://$ip:8080/images/${Uri.encodeComponent(imageFileName)}';
    } catch (e) {
      rethrow;
    }
  }
}
