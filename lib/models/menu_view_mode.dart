import 'package:flutter/material.dart';

enum MenuViewMode {
  list('Lista', Icons.view_list),
  grid('Cuadrícula', Icons.grid_view),
  cards('Tarjetas', Icons.view_agenda_outlined),
  classic('Clásica', Icons.menu_book_outlined);

  const MenuViewMode(this.label, this.icon);
  final String label;
  final IconData icon;
}
