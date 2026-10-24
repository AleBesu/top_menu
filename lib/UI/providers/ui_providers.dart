import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/app/app_colors.dart';

import '../../core/models/app_tab.dart';
import '../../core/enum/menu_layout_mode.dart';

class TabNotifier extends Notifier<AppTab> {
  @override
  AppTab build() => AppTab.general;
  void select(AppTab tab) => state = tab;
}

final tabProvider = NotifierProvider<TabNotifier, AppTab>(TabNotifier.new);

///////////

final menuViewConfigProvider =
    NotifierProvider<_MenuViewConfigNotifier, _MenuViewConfig>(
      _MenuViewConfigNotifier.new,
    );

class _MenuViewConfigNotifier extends Notifier<_MenuViewConfig> {
  @override
  _MenuViewConfig build() {
    return _MenuViewConfig(
      menuLayoutMode: MenuLayoutMode.list,
      schemeColor: AppColors.primary,
      isDarkTheme: true,
    );
  }

  void select(MenuLayoutMode mode) =>
      state = state.copyWith(menuLayoutMode: mode);
}

class _MenuViewConfig {
  final MenuLayoutMode menuLayoutMode;
  final Color schemeColor;
  final bool isDarkTheme;

  _MenuViewConfig({
    required this.menuLayoutMode,
    required this.schemeColor,
    required this.isDarkTheme,
  });

  _MenuViewConfig copyWith({
    MenuLayoutMode? menuLayoutMode,
    Color? schemeColor,
    bool? isDarkTheme,
  }) {
    return _MenuViewConfig(
      menuLayoutMode: menuLayoutMode ?? this.menuLayoutMode,
      schemeColor: schemeColor ?? this.schemeColor,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}
