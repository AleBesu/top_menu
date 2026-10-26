import 'dart:ui';

import 'package:top_menu/app/app_colors.dart';
import 'package:top_menu/core/enum/menu_layout_mode.dart';

import 'menu_category.dart';

class RestaurantConfig {
  final String? name;
  final String? bannerPath;
  final String? openTime; // HH:mm
  final String? closeTime; // HH:mm
  final String? address;
  final String? numberPhone;
  final bool isDarkTheme;
  final Color primaryColor;
  final List<MenuCategory> categories;
  final MenuLayoutMode menuLayoutMode;
  const RestaurantConfig({
    required this.name,
    this.bannerPath,
    required this.openTime,
    required this.closeTime,
    required this.categories,
    this.address,
    this.numberPhone,
    this.isDarkTheme = false,
    this.primaryColor = AppColors.primary,
    this.menuLayoutMode = MenuLayoutMode.list,
  });

  RestaurantConfig copyWith({
    String? name,
    String? bannerPath,
    bool clearBanner = false,
    String? openTime,
    String? closeTime,
    String? address,
    bool clearAddress = false,
    String? numberPhone,
    bool clearNumberPhone = false,
    bool? isDarkTheme,
    Color? primaryColor,
    List<MenuCategory>? categories,
    MenuLayoutMode? menuLayoutMode,
  }) => RestaurantConfig(
    name: name ?? this.name,
    bannerPath: clearBanner ? null : bannerPath ?? this.bannerPath,
    openTime: openTime ?? this.openTime,
    closeTime: closeTime ?? this.closeTime,
    address: clearAddress ? null : address ?? this.address,
    numberPhone: clearNumberPhone ? null : numberPhone ?? this.numberPhone,
    isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    primaryColor: primaryColor ?? this.primaryColor,
    categories: categories ?? this.categories,
    menuLayoutMode: menuLayoutMode ?? this.menuLayoutMode,
  );
}
