import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import '../../../app/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/models/menu_category.dart';
import '../net_image.dart';
import 'category_title.dart';

class ListMenuView extends ConsumerWidget {
  const ListMenuView({super.key, required this.categories});
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuConfigPro = ref.watch(menuConfigProvider);

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
                      child: FileImageWidget(p.imagePath),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: menuConfigPro.primaryColor,
                          ),
                        ),
                        if (p.description.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            p.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.muted,

                              // color: menuConfigPro.primaryColor.withOpacity(
                              //   0.7,
                              // ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    formatPrice(p.price),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: menuConfigPro.primaryColor,
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
