import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:top_menu/app/app_colors.dart';

class ServerScreen extends StatelessWidget {
  const ServerScreen({super.key, required this.ip, this.port = 8080});

  final String ip;
  final int port;

  String get serverUrl => 'http://$ip:$port';

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF050B14);
    const cardColor = Color(0xFF111A30);
    const primaryColor = Color(0xFF0A84FF);

    return Scaffold(
      // backgroundColor: backgroundColor,
      appBar: AppBar(
        // backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Servidor local',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: QrImageView(
                          data: serverUrl,
                          version: QrVersions.auto,
                          size: MediaQuery.of(context).size.width * 0.8,
                          backgroundColor: Colors.white,
                          errorCorrectionLevel: QrErrorCorrectLevel.M,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, color: Colors.greenAccent, size: 9),
                        SizedBox(width: 8),
                        Text(
                          'En ejecución',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '¡Servidor inicializado!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Escanea el código QR desde otro dispositivo '
                    'conectado a la misma red Wi-Fi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    'URL DE CONEXIÓN',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    serverUrl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF59AEFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () async {
                      // await stopServer();

                      //!Stop foregroundservice

                      await FlutterForegroundTask.stopService();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.stop_rounded),
                    label: const Text('Detener servidor'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.red500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
