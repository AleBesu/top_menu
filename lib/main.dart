import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/core/datasourses/hive_restaurant_local_data_source.dart';

import 'core/theme.dart';
import 'UI/screens/admi_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveRestaurantLocalDataSource.init();

  runApp(const ProviderScope(child: MenuAdminApp()));
}

class MenuAdminApp extends StatelessWidget {
  const MenuAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'TopMenu',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(),
        home: AdmiMenuScreen(),
      ),
    );
  }
}
