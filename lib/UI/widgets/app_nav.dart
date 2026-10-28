import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import '../../app/app_colors.dart';
import '../../core/models/app_tab.dart';
import '../providers/ui_providers.dart';

class AppTopTabs extends ConsumerWidget {
  const AppTopTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(tabProvider);
    final menuConfigPro = ref.watch(menuConfigProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Row(
        children: [
          for (final t in AppTab.values)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: t == AppTab.values.last ? 0 : 8,
                ),
                child: RawChip(
                  onPressed: () => ref.read(tabProvider.notifier).select(t),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                    side: BorderSide.none,
                  ),
                  backgroundColor: t == current
                      ? menuConfigPro.primaryColor
                      : menuConfigPro.isDarkTheme
                      ? AppColors.surface2
                      : AppColors.white,
                  label: Center(
                    child: Text(
                      t.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: t == current
                            ? AppColors.white
                            : menuConfigPro.isDarkTheme
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
