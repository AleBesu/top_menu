import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import 'app_colors.dart';

const kSerif = 'serif';

ThemeData buildTheme(WidgetRef ref) {
  final base = ThemeData.dark(useMaterial3: true);

  final menuConfigPro = ref.watch(menuConfigProvider);
  return base.copyWith(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
    brightness: Brightness.light,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      modalBackgroundColor: AppColors.surface,
    ),
  );
}
