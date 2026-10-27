import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/theme.dart';
import '../../../../core/utils.dart';
import '../../../../core/models/menu_category.dart';
import '../../../widgets/file_image_widget.dart';
import 'category_title.dart';

class CardsMenuView extends ConsumerWidget {
  const CardsMenuView({super.key, required this.categories});
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
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              clipBehavior: Clip.antiAlias,
              // decoration: BoxDecoration(
              //   color: AppColors.surface,
              //   border: Border.all(color: AppColors.border),
              //   borderRadius: BorderRadius.circular(16),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: FileImageWidget(p.imagePath),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: menuConfigPro.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            formatPrice(p.price),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: kSerif,
                            letterSpacing: -0.2,
                            color: menuConfigPro.primaryColor.withOpacity(0.8),
                          ),
                        ),
                        if (p.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            p.description,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.muted,
                              // color: menuConfigPro.primaryColor.withOpacity(
                              //   0.5,
                              // ),
                            ),
                          ),
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
