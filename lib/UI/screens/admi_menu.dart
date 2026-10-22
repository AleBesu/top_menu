import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/theme.dart';
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
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(tabProvider);
    final name = ref.watch(restaurantProvider.select((c) => c.name));

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
                      ElevatedButton(
                        onPressed: () {},
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
