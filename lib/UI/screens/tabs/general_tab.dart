import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../../../core/theme.dart';
import '../../providers/restaurant_provider.dart';
import '../../widgets/app_field.dart';
import '../../widgets/net_image.dart';
import '../../widgets/section_header.dart';

class GeneralTab extends ConsumerWidget {
  const GeneralTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(restaurantProvider);
    final notifier = ref.read(restaurantProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeader('Banner del local'),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                NetImage(config.banner),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Color(0x99000000), Colors.transparent],
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  bottom: 12,
                  child: Text(
                    config.name,
                    style: const TextStyle(
                      fontFamily: kSerif,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        AppField(
          label: 'URL de imagen del banner',
          initialValue: config.banner,
          onChanged: notifier.setBanner,
          hint: 'https://...',
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: 24),
        const SectionHeader('Información del local'),
        AppField(
          label: 'Nombre del local',
          initialValue: config.name,
          onChanged: notifier.setName,
          hint: 'Nombre del restaurante',
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: TimeField(
                label: 'Hora apertura',
                value: config.openTime,
                onChanged: notifier.setOpenTime,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TimeField(
                label: 'Hora cierre',
                value: config.closeTime,
                onChanged: notifier.setCloseTime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Horario de servicio',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.redSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Hoy activo',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      config.openTime,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(height: 4, color: AppColors.redSoft),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.surface2,
                      border: Border.fromBorderSide(
                        BorderSide(color: AppColors.border),
                      ),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      config.closeTime,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
