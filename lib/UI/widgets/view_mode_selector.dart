import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_colors.dart';
import '../../core/enum/menu_layout_mode.dart';
import '../providers/ui_providers.dart';

class ViewModeSelector extends ConsumerWidget {
  const ViewModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(menuViewConfigProvider);
    return Row(
      children: [
        for (final m in MenuLayoutMode.values)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: m == MenuLayoutMode.values.last ? 0 : 8,
              ),
              child: Material(
                color: m == current ? AppColors.redSoft : AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: m == current ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () =>
                      ref.read(menuViewConfigProvider.notifier).select(m),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        Icon(
                          m.icon,
                          size: 22,
                          color: m == current
                              ? AppColors.primary
                              : AppColors.muted,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: m == current
                                ? AppColors.primary
                                : AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
