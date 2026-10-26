import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:top_menu/UI/screens/server_iniciated_screen.dart';
import 'package:top_menu/core/services/server_handle/server_handle.dart';

import '../../app/app_colors.dart';
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
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PANEL DE ADMINISTRACIÓN',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (name != null)
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: kSerif,
                                  fontSize: 26,
                                  letterSpacing: -0.3,
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

                            final ip = await (NetworkInfo().getWifiIP());

                            if (ip != null) {
                              await ServerHandle.init(ref: ref);

                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ServerScreen(ip: ip, port: 8080),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    "Conectate a una red Wifi",
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
                            backgroundColor: AppColors.primary,
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
                          child: Text('Crear'),
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
}
