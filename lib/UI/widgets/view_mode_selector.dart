import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../core/models/menu_view_mode.dart';
import '../providers/ui_providers.dart';

class ViewModeSelector extends ConsumerWidget {
  const ViewModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(viewModeProvider);
    return Row(
      children: [
        for (final m in MenuViewMode.values)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: m == MenuViewMode.values.last ? 0 : 8,
              ),
              child: Material(
                color: m == current ? AppColors.redSoft : AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: m == current ? AppColors.red : AppColors.border,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => ref.read(viewModeProvider.notifier).select(m),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        Icon(
                          m.icon,
                          size: 22,
                          color: m == current ? AppColors.red : AppColors.muted,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          m.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: m == current
                                ? AppColors.red
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
