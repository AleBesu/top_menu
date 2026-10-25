import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/widgets/color_selector.dart';
import 'package:top_menu/UI/widgets/dialogs/show_colors_select.dart';
import 'package:top_menu/app/app_colors.dart';
import 'package:top_menu/core/services/file_handle/file_handle.dart';

import '../../../app/theme.dart';
import '../../providers/restaurant_provider.dart';
import '../../widgets/app_field.dart';
import '../../widgets/net_image.dart';
import '../../widgets/section_header.dart';

class GeneralTab extends ConsumerWidget {
  const GeneralTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuConfigPro = ref.watch(menuConfigProvider);
    final menuConfigNotifier = ref.read(menuConfigProvider.notifier);

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
                FileImageWidget(menuConfigPro.bannerPath),
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
                    menuConfigPro.name,
                    style: const TextStyle(
                      fontFamily: kSerif,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: IconButton.filled(
                    onPressed: () async {
                      final newImage = await FilesManagerService.pickerImage(
                        copyToAppDirectory: true,
                      );

                      if (newImage != null) {
                        ref
                            .read(menuConfigProvider.notifier)
                            .setBanner(newImage.file.path);
                      }
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),
        const SectionHeader('Información del local'),
        AppField(
          label: 'Nombre del local',
          initialValue: menuConfigPro.name,
          onChanged: menuConfigNotifier.setName,
          hint: 'Nombre del restaurante',
        ),
        const SizedBox(height: 16),

        FieldTitle('Color de Marca'),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: BlockPicker(
                // useInShowDialog: true,
                pickerColor: Colors.blue,
                layoutBuilder: (context, colors, child) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 40,
                        ),
                    itemCount: colors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(child: child(colors[index]));
                    },
                  );
                },
                itemBuilder: (color, isCurrentColor, changeColor) => Material(
                  color: Colors.transparent,

                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: changeColor,
                    ),
                  ),
                ),
                onColorChanged: (color) {
                  menuConfigNotifier.setPrimaryColor(color);
                },
                availableColors: [
                  Colors.blue,
                  Colors.amberAccent,
                  Colors.green,
                  Colors.red,
                  Colors.pink,
                ],
              ),
            ),
            SizedBox(width: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  final pickedColor = await showColorPicker(context);
                  if (pickedColor != null) {
                    menuConfigNotifier.setPrimaryColor(pickedColor);
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white54,
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),

        // Row(
        //   children: [
        //     Expanded(
        //       child: TimeField(
        //         label: 'Hora apertura',
        //         value: config.openTime,
        //         onChanged: notifier.setOpenTime,
        //       ),
        //     ),
        //     const SizedBox(width: 12),
        //     Expanded(
        //       child: TimeField(
        //         label: 'Hora cierre',
        //         value: config.closeTime,
        //         onChanged: notifier.setCloseTime,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 24),
        // Container(
        //   padding: const EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //     color: AppColors.surface,
        //     border: Border.all(color: AppColors.border),
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           const Expanded(
        //             child: Text(
        //               'Horario de servicio',
        //               style: TextStyle(
        //                 fontSize: 13,
        //                 fontWeight: FontWeight.w500,
        //                 color: AppColors.muted,
        //               ),
        //             ),
        //           ),
        //           Container(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 10,
        //               vertical: 3,
        //             ),
        //             decoration: BoxDecoration(
        //               color: AppColors.redSoft,
        //               borderRadius: BorderRadius.circular(20),
        //             ),
        //             child: const Text(
        //               'Hoy activo',
        //               style: TextStyle(
        //                 fontSize: 11,
        //                 fontWeight: FontWeight.w600,
        //                 color: AppColors.primary,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       const SizedBox(height: 12),
        //       Row(
        //         children: [
        //           Container(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 14,
        //               vertical: 8,
        //             ),
        //             decoration: const BoxDecoration(
        //               color: AppColors.primary,
        //               borderRadius: BorderRadius.horizontal(
        //                 left: Radius.circular(6),
        //               ),
        //             ),
        //             child: Text(
        //               config.openTime,
        //               style: const TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w700,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //           Expanded(
        //             child: Container(height: 4, color: AppColors.redSoft),
        //           ),
        //           Container(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 14,
        //               vertical: 8,
        //             ),
        //             decoration: const BoxDecoration(
        //               color: AppColors.surface2,
        //               border: Border.fromBorderSide(
        //                 BorderSide(color: AppColors.border),
        //               ),
        //               borderRadius: BorderRadius.horizontal(
        //                 right: Radius.circular(6),
        //               ),
        //             ),
        //             child: Text(
        //               config.closeTime,
        //               style: const TextStyle(
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
