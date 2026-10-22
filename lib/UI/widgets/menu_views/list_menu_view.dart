import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/models/menu_category.dart';
import '../net_image.dart';
import 'category_title.dart';

class ListMenuView extends StatelessWidget {
  const ListMenuView({super.key, required this.categories});
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final c in categories) ...[
          CategoryTitle(c.name),
          for (final p in c.products)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 72,
                      height: 72,
                      child: NetImage(p.image),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (p.description.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            p.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    formatPrice(p.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
