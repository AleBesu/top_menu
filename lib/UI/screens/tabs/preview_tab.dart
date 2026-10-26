import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/screens/tabs/preview_tab_widgets/cards_menu_view.dart';
import 'package:top_menu/UI/screens/tabs/preview_tab_widgets/classic_menu_view.dart';
import 'package:top_menu/UI/screens/tabs/preview_tab_widgets/grid_menu_view.dart';
import 'package:top_menu/UI/screens/tabs/preview_tab_widgets/list_menu_view.dart';
import 'package:top_menu/app/app_colors.dart';
import 'package:top_menu/core/enum/menu_layout_mode.dart';
import 'package:top_menu/core/models/menu_category.dart';

import '../../../app/theme.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/ui_providers.dart';

import '../../widgets/net_image.dart';
import '../../widgets/section_header.dart';
import '../../widgets/view_mode_selector.dart';

class PreviewTab extends ConsumerStatefulWidget {
  const PreviewTab({super.key});

  @override
  ConsumerState<PreviewTab> createState() => _PreviewTabState();
}

class _PreviewTabState extends ConsumerState<PreviewTab> {
  @override
  Widget build(BuildContext context) {
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
    // final menuViewConfigPro = ref.watch(menuViewConfigProvider);

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

        scaffoldBackgroundColor: menuConfigPro.isDarkTheme
            ? Color.alphaBlend(
                menuConfigPro.primaryColor.withOpacity(0.07),
                Colors.black,
              )
            : Color.alphaBlend(
                menuConfigPro.primaryColor.withOpacity(0.25),
                Colors.white,
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
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    if (menuConfigPro.bannerPath != null) ...[
                      SizedBox(
                        height: 170,
                        child: FileImageWidget(menuConfigPro.bannerPath),
                      ),

                      if ((menuConfigPro.name != null &&
                              menuConfigPro.name!.isNotEmpty) ||
                          menuConfigPro.openTime != null &&
                              menuConfigPro.openTime!.isNotEmpty)
                        Positioned.fill(
                          child: const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Color(0xCC000000), Colors.transparent],
                                stops: [0, 0.8],
                              ),
                            ),
                          ),
                        ),

                      Positioned(
                        bottom: 14,
                        left: 14,
                        child: SizedBox(
                          width:
                              MediaQuery.of(context).size.width -
                              24, //24 is the value of de padding (12 + 12)
                          child: _buildMainInfoWidget(
                            name: menuConfigPro.name,
                            closeTime: menuConfigPro.closeTime,
                            openTime: menuConfigPro.openTime,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ] else
                      Card(
                        child: SizedBox(
                          height: 140,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                                horizontal: 40,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 24, //24 is the value of de padding (12 + 12)

                                child: _buildMainInfoWidget(
                                  name: menuConfigPro.name,
                                  closeTime: menuConfigPro.closeTime,
                                  openTime: menuConfigPro.openTime,
                                  textColor: menuConfigPro.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _MenuViewBuilder(
                  mode: menuConfigPro.menuLayoutMode,
                  categories: menuConfigPro.categories,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfoWidget({
    String? name,
    String? openTime,
    String? closeTime,
    Color textColor = Colors.white,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    //horario
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (name != null && name.isNotEmpty)
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontFamily: kSerif,
              fontSize: 23,
              height: 1,
              color: textColor,
            ),
          ),
        const SizedBox(height: 6),
        Text(
          'Abierto de $openTime a $closeTime',
          style: TextStyle(fontSize: 11, color: AppColors.muted),
        ),
      ],
    );
  }
}

class _MenuViewBuilder extends StatelessWidget {
  const _MenuViewBuilder({required this.mode, required this.categories});
  final MenuLayoutMode mode;
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    final visible = categories.where((c) => c.products.isNotEmpty).toList();
    if (visible.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            'Añade platos en la pestaña Carta para verlos aquí.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted),
          ),
        ),
      );
    }
    return switch (mode) {
      MenuLayoutMode.list => ListMenuView(categories: visible),
      MenuLayoutMode.grid => GridMenuView(categories: visible),
      MenuLayoutMode.cards => CardsMenuView(categories: visible),
      MenuLayoutMode.classic => ClassicMenuView(categories: visible),
    };
  }
}
