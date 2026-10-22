import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_tab.dart';
import '../models/menu_view_mode.dart';

class TabNotifier extends Notifier<AppTab> {
  @override
  AppTab build() => AppTab.general;
  void select(AppTab tab) => state = tab;
}

final tabProvider = NotifierProvider<TabNotifier, AppTab>(TabNotifier.new);

class ViewModeNotifier extends Notifier<MenuViewMode> {
  @override
  MenuViewMode build() => MenuViewMode.list;
  void select(MenuViewMode mode) => state = mode;
}

final viewModeProvider =
    NotifierProvider<ViewModeNotifier, MenuViewMode>(ViewModeNotifier.new);
