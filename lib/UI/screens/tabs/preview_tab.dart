import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/app/app_colors.dart';

import '../../../app/theme.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/ui_providers.dart';
import '../../widgets/menu_products_widgets/menu_view_builder.dart';
import '../../widgets/net_image.dart';
import '../../widgets/section_header.dart';
import '../../widgets/view_mode_selector.dart';

class PreviewTab extends ConsumerWidget {
  const PreviewTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(menuConfigProvider);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionHeader('Formato de visualización'),
        const ViewModeSelector(),
        const SizedBox(height: 28),
        SectionHeader(
          'Vista previa',
          actionBotton: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _buildPreviewScreen(ref),
                ),
              );
            },
            child: Icon(Icons.visibility, color: AppColors.primary),
          ),
        ),

        SizedBox(
          height: 400,
          child: Card(
            color: config.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: _buildPreviewScreen(ref),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewScreen(WidgetRef ref) {
    final menuConfigPro = ref.watch(menuConfigProvider);
    final menuViewConfigPro = ref.watch(menuViewConfigProvider);

    return Theme(
      data: ThemeData(
        // scaffoldBackgroundColor: Color.alphaBlend(
        //   menuConfigPro.primaryColor.withOpacity(0.2),
        //   menuConfigPro.isDarkTheme ? Colors.black26 : Colors.white,
        // ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: menuConfigPro.primaryColor,
          brightness: menuConfigPro.isDarkTheme
              ? Brightness.dark
              : Brightness.light,
        ),

        scaffoldBackgroundColor: Color.alphaBlend(
          menuConfigPro.primaryColor.withOpacity(0.25),
          menuConfigPro.isDarkTheme ? Colors.black26 : Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Vista Previa')),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      FileImageWidget(menuConfigPro.bannerPath),
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
                              menuConfigPro.name,
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
                              'Abierto de ${menuConfigPro.openTime} a ${menuConfigPro.closeTime}',
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
              MenuViewBuilder(
                mode: menuViewConfigPro.menuLayoutMode,
                categories: menuConfigPro.categories,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
