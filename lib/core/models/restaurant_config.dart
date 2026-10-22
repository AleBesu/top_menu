import 'menu_category.dart';

class RestaurantConfig {
  final String name;
  final String? bannerPath;
  final String openTime; // HH:mm
  final String closeTime; // HH:mm
  final List<MenuCategory> categories;

  const RestaurantConfig({
    required this.name,
    this.bannerPath,
    required this.openTime,
    required this.closeTime,
    required this.categories,
  });

  RestaurantConfig copyWith({
    String? name,
    String? banner,
    String? openTime,
    String? closeTime,
    List<MenuCategory>? categories,
  }) => RestaurantConfig(
    name: name ?? this.name,
    bannerPath: banner ?? this.bannerPath,
    openTime: openTime ?? this.openTime,
    closeTime: closeTime ?? this.closeTime,
    categories: categories ?? this.categories,
  );
}
