import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../core/models/menu_category.dart';
import '../../../core/enum/menu_layout_mode.dart';
import 'cards_menu_view.dart';
import 'classic_menu_view.dart';
import 'grid_menu_view.dart';
import 'list_menu_view.dart';

class MenuViewBuilder extends StatelessWidget {
  const MenuViewBuilder({
    super.key,
    required this.mode,
    required this.categories,
  });
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
