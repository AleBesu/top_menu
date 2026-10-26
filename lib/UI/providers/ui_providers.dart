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
