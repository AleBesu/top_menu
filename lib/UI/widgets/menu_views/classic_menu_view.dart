import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/theme.dart';
import '../../../core/utils.dart';
import '../../../core/models/menu_category.dart';

/// Carta tipográfica sin imágenes: nombre ······ precio.
class ClassicMenuView extends StatelessWidget {
  const ClassicMenuView({super.key, required this.categories});
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (final c in categories) ...[
            Text(
              c.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: kSerif,
                fontSize: 18,
                letterSpacing: 4,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Container(width: 32, height: 1, color: AppColors.primary),
            const SizedBox(height: 20),
            for (final p in c.products)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontFamily: kSerif,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            '· · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: AppColors.border),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formatPrice(p.price),
                          style: const TextStyle(
                            fontFamily: kSerif,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (p.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          p.description,
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
