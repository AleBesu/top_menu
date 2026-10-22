import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/models/app_tab.dart';
import '../providers/ui_providers.dart';

class AppTopTabs extends ConsumerWidget {
  const AppTopTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(tabProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border),
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          for (final t in AppTab.values)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: t == AppTab.values.last ? 0 : 8,
                ),
                child: Material(
                  color: t == current ? AppColors.primary : AppColors.surface2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                    side: t == current
                        ? BorderSide.none
                        : const BorderSide(color: AppColors.border),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(9),
                    onTap: () => ref.read(tabProvider.notifier).select(t),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          t.label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: t == current
                                ? Colors.white
                                : AppColors.muted,
                          ),
                        ),
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
