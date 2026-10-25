import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import '../../../../app/app_colors.dart';

class CategoryTitle extends ConsumerWidget {
  const CategoryTitle(this.name, {super.key});
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuConfigPro = ref.watch(menuConfigProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: menuConfigPro.primaryColor,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Divider(
              color: menuConfigPro.primaryColor.withOpacity(0.5),
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
