import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../models/menu_category.dart';
import '../net_image.dart';
import 'category_title.dart';

class CardsMenuView extends StatelessWidget {
  const CardsMenuView({super.key, required this.categories});
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final c in categories) ...[
          CategoryTitle(c.name),
          for (final p in c.products)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(aspectRatio: 16 / 9, child: NetImage(p.image)),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(formatPrice(p.price),
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name,
                            style: const TextStyle(
                                fontSize: 19,
                                fontFamily: kSerif,
                                letterSpacing: -0.2)),
                        if (p.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(p.description,
                              style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: AppColors.muted)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
