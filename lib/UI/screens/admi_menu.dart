import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_device_settings/open_device_settings.dart';
import 'package:open_device_settings/settings_panel.dart';
import 'package:top_menu/UI/screens/loading_screen.dart';
import 'package:top_menu/UI/screens/select_network_screen.dart';

import 'package:top_menu/UI/screens/server_iniciated_screen.dart';
import 'package:top_menu/core/services/server_handle/server_handle.dart';
import 'package:top_menu/main.dart';

import '../../app/theme.dart';
import '../../core/models/app_tab.dart';
import '../providers/restaurant_provider.dart';
import '../providers/ui_providers.dart';
import '../widgets/app_nav.dart';
import 'tabs/general_tab.dart';
import 'tabs/menu_tab.dart';
import 'tabs/preview_tab.dart';

class AdmiMenuScreen extends ConsumerStatefulWidget {
  const AdmiMenuScreen({super.key});

  @override
  ConsumerState<AdmiMenuScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<AdmiMenuScreen> {
  bool isLoading = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(tabProvider);
    final name = ref.watch(menuConfigProvider.select((c) => c.name));

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PANEL DE ADMINISTRACIÓN',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: ref
                                    .watch(menuConfigProvider)
                                    .primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (name != null)
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: kSerif,
                                  fontSize: 26,
                                  letterSpacing: -0.3,
                                  color: ref
                                      .watch(menuConfigProvider)
                                      .primaryColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (isLoading)
                        CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              final navigator = Navigator.of(context);

                              await navigator.push(
                                MaterialPageRoute(
                                  builder: (context) => SelectNetworkScreen(
                                    //conect to wifi
                                    onConnectWifi: () async {
                                      if (await DeviceSettings.isSupported(
                                        SettingsPanel.wifi,
                                      )) {
                                        await DeviceSettings.open(
                                          SettingsPanel.wifi,
                                        );
                                      } else {
                                        await DeviceSettings.openSystemSettings();
                                      }
                                    },

                                    //init hospot
                                    onStartHotspot: () async {
                                      if (await DeviceSettings.isSupported(
                                        SettingsPanel.hotspot,
                                      )) {
                                        await DeviceSettings.open(
                                          SettingsPanel.hotspot,
                                        );
                                      } else {
                                        await DeviceSettings.openSystemSettings();
                                      }
                                    },

                                    onInitServer: () async {
                                      await initServer();
                                    },
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(navigatorKey.currentContext!)
                                  .showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "Conectate a una red",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                            }

                            await ServerHandle.stopServer();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ref
                                .watch(menuConfigProvider)
                                .primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: Text('Iniciar'),
                        ),
                    ],
                  ),
                ),
                const AppTopTabs(),
                //bodys
                Expanded(
                  child: switch (tab) {
                    AppTab.general => const GeneralTab(),
                    AppTab.menu => const MenuTab(),
                    AppTab.preview => const PreviewTab(),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initServer() async {
    final navigator = Navigator.of(context);

    try {
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => LoadingScreen<String>(
            onLoad: () async {
              try {
                String? ip = await ServerHandle.getDeviceIp();
                if (ip == null) {
                  throw ('Conecct to network');
                }
                await ServerHandle.init(ref: ref);

                return ip;
              } catch (e) {
                rethrow;
              }
            },

            onFinish: (ip) async {
              //!go back of LoadingScreen to SelectNetworkScreen
              navigator.pop();

              //!replace SelectNetworkScreen in the navigator,for when you go back you go to main screen
              await navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (_) => ServerScreen(ip: ip, port: 8080),
                ),
              );
            },
            onError: (error) {
              ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  content: Text(
                    "Conectate a una red o crea un punto de acceso",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
              navigator.pop();
            },
          ),
        ),
      );
    } catch (e) {
      navigator.pop();

      rethrow;
    }
  }
}
