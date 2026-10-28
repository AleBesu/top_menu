import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/UI/providers/restaurant_provider.dart';

import 'app_colors.dart';

const kSerif = 'serif';

ThemeData buildLightTheme(WidgetRef ref) {
  final base = ThemeData(useMaterial3: true);

  final menuConfigPro = ref.watch(menuConfigProvider);
  return base.copyWith(
    colorScheme: ColorScheme.light(primary: menuConfigPro.primaryColor),
    chipTheme: ChipThemeData(side: BorderSide.none),

    dividerTheme: DividerThemeData(color: AppColors.muted.withOpacity(0.5)),
    scaffoldBackgroundColor: Color.alphaBlend(
      menuConfigPro.primaryColor.withOpacity(0.25),
      Colors.white,
    ),

    // cardTheme: CardThemeData(color: AppColors.primary.withOpacity(0.5)),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.surface),
        side: WidgetStatePropertyAll(BorderSide(color: AppColors.muted)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white)),
    ),
    // textTheme: base.textTheme.apply(
    //   bodyColor: AppColors.text,
    //   displayColor: AppColors.text,
    // ),
    // brightness: Brightness.light,
    // textTheme: TextTheme(),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      modalBackgroundColor: AppColors.surface,
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.muted),

      filled: true,
      fillColor: AppColors.white,
      // isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: _border(AppColors.muted),
      enabledBorder: _border(AppColors.muted),
      focusedBorder: _border(menuConfigPro.primaryColor),
      errorBorder: _border(menuConfigPro.primaryColor),
      focusedErrorBorder: _border(menuConfigPro.primaryColor),
    ),
  );

  // style: const TextStyle(fontSize: 14, color: AppColors.text),
  // decoration: InputDecoration(
  //   hintText: hint,
  //   hintStyle: const TextStyle(color: AppColors.muted),
  //   errorText: errorText,
  //   filled: true,
  //   fillColor: AppColors.surface2,
  //   isDense: true,
  //   contentPadding: const EdgeInsets.symmetric(
  //     horizontal: 12,
  //     vertical: 12,
  //   ),
  //   border: _border(AppColors.border),
  //   enabledBorder: _border(AppColors.border),
  //   focusedBorder: _border(AppColors.primary),
  //   errorBorder: _border(AppColors.primary),
  //   focusedErrorBorder: _border(AppColors.primary),
  // ),
}

ThemeData buildDarkTheme(WidgetRef ref) {
  final base = ThemeData(useMaterial3: true);

  final menuConfigPro = ref.watch(menuConfigProvider);
  return base.copyWith(
    chipTheme: ChipThemeData(side: BorderSide.none),
    colorScheme: ColorScheme.dark(
      primary: menuConfigPro.primaryColor,
      brightness: menuConfigPro.isDarkTheme
          ? Brightness.dark
          : Brightness.light,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.white),
        side: WidgetStatePropertyAll(BorderSide(color: AppColors.muted)),
      ),
    ),
    dividerTheme: DividerThemeData(color: AppColors.muted.withOpacity(0.5)),
    cardTheme: CardThemeData(color: AppColors.surface2),
    scaffoldBackgroundColor: Color.alphaBlend(
      menuConfigPro.primaryColor.withOpacity(0.07),
      Colors.black,
    ),

    // outlinedButtonTheme: OutlinedButtonThemeData(
    //   style: ButtonStyle(
    //     side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary)),
    //   ),
    // ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(menuConfigPro.primaryColor),
      ),
    ),
    // textTheme: base.textTheme.apply(
    //   bodyColor: AppColors.text,
    //   displayColor: AppColors.text,
    // ),
    // brightness: Brightness.light,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      modalBackgroundColor: AppColors.surface,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.text),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.muted),

      filled: true,
      fillColor: AppColors.surface2,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: _border(AppColors.border),
      enabledBorder: _border(AppColors.border),
      focusedBorder: _border(menuConfigPro.primaryColor),
      errorBorder: _border(menuConfigPro.primaryColor),
      focusedErrorBorder: _border(menuConfigPro.primaryColor),
    ),
  );

  // style: const TextStyle(fontSize: 14, color: AppColors.text),
  // decoration: InputDecoration(
  //   hintText: hint,
  //   hintStyle: const TextStyle(color: AppColors.muted),
  //   errorText: errorText,
  //   filled: true,
  //   fillColor: AppColors.surface2,
  //   isDense: true,
  //   contentPadding: const EdgeInsets.symmetric(
  //     horizontal: 12,
  //     vertical: 12,
  //   ),
  //   border: _border(AppColors.border),
  //   enabledBorder: _border(AppColors.border),
  //   focusedBorder: _border(AppColors.primary),
  //   errorBorder: _border(AppColors.primary),
  //   focusedErrorBorder: _border(AppColors.primary),
  // ),
}

OutlineInputBorder _border(Color c) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(color: c),
);
