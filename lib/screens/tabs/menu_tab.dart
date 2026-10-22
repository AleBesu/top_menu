import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/app_colors.dart';
import '../../providers/restaurant_provider.dart';
import '../../widgets/category_card.dart';
import '../../widgets/section_header.dart';

class MenuTab extends ConsumerWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories =
        ref.watch(restaurantProvider.select((c) => c.categories));

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SectionHeader('Carta — ${categories.length} categorías'),
        for (final c in categories)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CategoryCard(key: ValueKey(c.id), category: c),
          ),
        OutlinedButton(
          onPressed: ref.read(restaurantProvider.notifier).addCategory,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.muted,
            side: const BorderSide(color: AppColors.border),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('+ Nueva categoría',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
