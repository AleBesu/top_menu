import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:flutter_foreground_task/task_handler.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(AppForegroundTask());
}

class AppForegroundService {
  static AppForegroundService instance = AppForegroundService._();
  AppForegroundService._();
}

class AppForegroundTask extends TaskHandler {
  HttpServer? _server;

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {
    _server?.close();
    _server = null;
  }

  @override
  void onNotificationButtonPressed(String id) {
    FlutterForegroundTask.sendDataToMain({'action': 'stop_server'});
    if (id == 'stop_server') {
      FlutterForegroundTask.stopService();
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // TODO: implement onRepeatEvent
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    print('object');
  }

  @override
  void onReceiveData(Object data) {
    data = data as Map<String, dynamic>;
    if (data['action'] == 'setServerData') {
      _initServer(data['payload']);
    }
  }

  Future<void> _initServer(Map<String, dynamic> payload) async {
    //web handle
    String? serverIp;
    try {
      Handler webHandler = createStaticHandler(
        payload['web-local-path'],
        defaultDocument: 'index.html',
      );
      Handler apiHandler = _createMenuRouter(payload);

      final serverHandler = Cascade().add(webHandler).add(apiHandler).handler;

      serverIp = payload['ip'];
      if (serverIp == null) {
        throw ('Serverip cannot be null');
      } else {
        _server = await shelf_io.serve(serverHandler, serverIp, 8080);
      }
    } catch (e) {
      rethrow;
    }
  }

  Handler _createMenuRouter(Map<String, dynamic> payload) {
    final router = Router();

    // GET /get-menu-config
    router.get('/get-menu-config', (Request request) {
      return Response.ok(
        jsonEncode(payload['/get-menu-config']),
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });

    // GET /fetch-categories-list
    router.get('/fetch-categories-list', (Request request) {
      return Response.ok(
        jsonEncode(payload['/fetch-categories-list']),
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });

    // GET /images/<nombre-del-archivo>
    final imagesPath = payload['/images/'];

    if (imagesPath is String && imagesPath.isNotEmpty) {
      router.mount('/images/', createStaticHandler(imagesPath));
    }

    return router;
  }
}
