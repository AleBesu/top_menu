import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../core/utils.dart';
import '../../../core/models/menu_category.dart';
import '../../../core/models/product.dart';
import '../net_image.dart';
import 'category_title.dart';

class GridMenuView extends StatelessWidget {
  const GridMenuView({super.key, required this.categories});
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final c in categories) ...[
          CategoryTitle(c.name),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.68,
            children: [for (final p in c.products) _Tile(product: p)],
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: FileImageWidget(product.imagePath)),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                  Text(
                    formatPrice(product.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
