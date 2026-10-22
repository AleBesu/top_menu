import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'UI/screens/home_screen.dart';

void main() => runApp(const ProviderScope(child: MenuAdminApp()));

class MenuAdminApp extends StatelessWidget {
  const MenuAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'TopMenu',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: const HomeScreen(),
      ),
    );
  }
}
