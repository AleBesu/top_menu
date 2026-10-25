import 'package:flutter/material.dart';

enum AppTab {
  general('General', Icons.settings_outlined),
  menu('Productos', Icons.restaurant_menu),
  preview('Carta', Icons.visibility_outlined);

  const AppTab(this.label, this.icon);
  final String label;
  final IconData icon;
}
