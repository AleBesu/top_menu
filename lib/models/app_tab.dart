import 'package:flutter/material.dart';

enum AppTab {
  general('General', Icons.settings_outlined),
  menu('Carta', Icons.restaurant_menu),
  preview('Vista', Icons.visibility_outlined);

  const AppTab(this.label, this.icon);
  final String label;
  final IconData icon;
}
