import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/widgets/color_selector.dart';
import 'package:top_menu/UI/widgets/dialogs/show_colors_select.dart';
import 'package:top_menu/UI/widgets/dialogs/show_question_dialog.dart';
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

    final isDarkTheme = menuConfigPro.isDarkTheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeader('Banner del local'),

        //====BANNER FIELD==
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

                if (menuConfigPro.name != null &&
                    menuConfigPro.name!.isNotEmpty)
                  Positioned(
                    left: 14,
                    bottom: 12,
                    child: Text(
                      menuConfigPro.name!,
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
                  child: Row(
                    children: [
                      IconButton.filled(
                        onPressed: () async {
                          final newImage =
                              await FilesManagerService.pickerImage(
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

                      if (menuConfigPro.bannerPath != null)
                        IconButton.filled(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                          ),
                          onPressed: () async {
                            await showQuestionDialog(
                              context,
                              question:
                                  "Estás seguro que desea borrar el banner?",
                              onAccept: () {
                                menuConfigNotifier.setBanner(null, true);
                                Navigator.of(context).pop();
                              },
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        ///////===============INFO===
        const SizedBox(height: 24),
        const SectionHeader('Información del local'),
        AppField(
          label: 'Nombre del local',
          initialValue: menuConfigPro.name,
          onChanged: menuConfigNotifier.setName,
          hint: 'Nombre del restaurante',
        ),

        const SizedBox(height: 16),

        AppField(
          label: 'NÚMERO DE TÉLEFONO',
          initialValue: menuConfigPro.name,
          onChanged: menuConfigNotifier.setNumberPhone,
          hint: 'Ej. +1 780-682-1113',
        ),

        const SizedBox(height: 16),
        AppField(
          label: 'DIRECCIÓN',
          initialValue: menuConfigPro.name,
          onChanged: menuConfigNotifier.setAddress,
          hint: 'Ej. Calle 123, Apt. 4B',
        ),

        const SizedBox(height: 16),

        //=======TEMA============
        FieldTitle('Tema'),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Colors.blue, width: 1.5),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    !isDarkTheme ? AppColors.primary : Colors.transparent,
                  ),
                  foregroundColor: !isDarkTheme
                      ? WidgetStatePropertyAll(Colors.white)
                      : null,
                ),
                onPressed: () {
                  // Activar modo claro
                  menuConfigNotifier.setIsDarkTheme(false);
                },
                icon: Icon(
                  !isDarkTheme ? Icons.light_mode : Icons.light_mode_outlined,
                ),
                label: const Text('Modo claro'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: OutlinedButton.icon(
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Colors.blue, width: 1.5),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    isDarkTheme ? AppColors.primary : Colors.transparent,
                  ),
                  foregroundColor: isDarkTheme
                      ? WidgetStatePropertyAll(Colors.white)
                      : null,
                ),
                onPressed: () {
                  // Activar modo oscuro

                  menuConfigNotifier.setIsDarkTheme(true);
                },
                icon: Icon(
                  isDarkTheme ? Icons.dark_mode : Icons.dark_mode_outlined,
                ),
                label: const Text('Modo oscuro'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        ///=====COLOR DE MARCA
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
                      border: isCurrentColor
                          ? Border.all(color: Colors.white, width: 2)
                          : null,
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
                  menuConfigPro.primaryColor,

                  Colors.red,
                  Colors.green,

                  Colors.blue,
                  Colors.white,
                  // Colors.black,
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

        SizedBox(height: 19),

        Row(
          children: [
            Expanded(
              child: TimeField(
                label: 'Hora apertura',
                value: menuConfigPro.openTime,
                onChanged: menuConfigNotifier.setOpenTime,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TimeField(
                label: 'Hora cierre',
                value: menuConfigPro.closeTime,
                onChanged: menuConfigNotifier.setCloseTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
