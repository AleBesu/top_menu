import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/ui_providers.dart';
import '../../widgets/menu_views/menu_view_builder.dart';
import '../../widgets/net_image.dart';
import '../../widgets/section_header.dart';
import '../../widgets/view_mode_selector.dart';

class PreviewTab extends ConsumerWidget {
  const PreviewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(restaurantProvider);
    final mode = ref.watch(viewModeProvider);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeader('Formato de visualización'),
        const ViewModeSelector(),
        const SizedBox(height: 28),
        const SectionHeader('Vista previa'),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                NetImage(config.banner),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xCC000000), Colors.transparent],
                      stops: [0, 0.8],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        config.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: kSerif,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Abierto de ${config.openTime} a ${config.closeTime}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xCCFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        MenuViewBuilder(mode: mode, categories: config.categories),
        const SizedBox(height: 12),
      ],
    );
  }
}
