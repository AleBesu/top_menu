import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

class SelectNetworkScreen extends ConsumerWidget {
  final VoidCallback onConnectWifi;
  final VoidCallback onStartHotspot;
  final VoidCallback onInitServer;
  const SelectNetworkScreen({
    super.key,
    required this.onConnectWifi,
    required this.onStartHotspot,
    required this.onInitServer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuConfigPro = ref.watch(menuConfigProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración de red')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.wifi, size: 64, color: menuConfigPro.primaryColor),
              const SizedBox(height: 16),
              const Text(
                'Conexiones de red',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              FilledButton.icon(
                onPressed: onInitServer,
                icon: const Icon(Icons.dns),
                label: const Text('Iniciar Servidor'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: onConnectWifi,
                icon: const Icon(Icons.wifi),
                label: const Text('Conectarse a una Wi-Fi'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),

              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: onStartHotspot,
                icon: const Icon(Icons.wifi_tethering),
                label: const Text('Iniciar punto de acceso'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),

              const SizedBox(height: 32),
              // Información adicional
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: menuConfigPro.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: menuConfigPro.primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: menuConfigPro.primaryColor,
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Asegúrate de que el dispositivo pertenesca a una red ya sea Wi-Fi o Punto de acceso',

                        style: TextStyle(
                          color: menuConfigPro.primaryColor,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
