import 'dart:convert';

import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:top_menu/core/extensions/color.dart';
import 'package:top_menu/core/models/menu_category.dart';
import 'package:top_menu/core/models/product.dart';
import 'package:top_menu/core/models/restaurant_config.dart';
import 'package:top_menu/core/models/restaurant_config_repository.dart';

class HiveRestaurantLocalDataSource implements RestaurantLocalDataSource {
  static const String boxName = 'restaurant_config_box';
  static const String _configKey = 'restaurant_config';

  /// Se debe ejecutar antes de crear la aplicación.
  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<String>(boxName);
    }
  }

  Box<String> get _box => Hive.box<String>(boxName);

  @override
  RestaurantConfig? getConfig() {
    final jsonString = _box.get(_configKey);

    if (jsonString == null) return null;

    final json = Map<String, dynamic>.from(jsonDecode(jsonString) as Map);

    return _configFromMap(json);
  }

  @override
  Future<void> saveConfig(RestaurantConfig config) async {
    final jsonString = jsonEncode(_configToMap(config));

    await _box.put(_configKey, jsonString);
  }

  @override
  Future<void> deleteConfig() async {
    await _box.delete(_configKey);
  }

  // ── Serialización

  Map<String, dynamic> _configToMap(RestaurantConfig config) {
    return {
      'name': config.name,
      'banner': config.bannerPath,
      'openTime': config.openTime,
      'closeTime': config.closeTime,
      'categories': config.categories.map(_categoryToMap).toList(),
    };
  }

  RestaurantConfig _configFromMap(Map<String, dynamic> json) {
    final categoriesJson = json['categories'] as List<dynamic>? ?? const [];

    return RestaurantConfig(
      name: json['name'] as String,
      bannerPath: json['banner'] as String?,
      openTime: json['openTime'] as String?,
      closeTime: json['closeTime'] as String?,
      primaryColor: colorFromJson(json['primaryColor']),
      address: json['address'],
      categories: categoriesJson.map((value) {
        return _categoryFromMap(Map<String, dynamic>.from(value as Map));
      }).toList(),
    );
  }

  Map<String, dynamic> _categoryToMap(MenuCategory category) {
    return {
      'id': category.id,
      'name': category.name,
      'products': category.products.map(_productToMap).toList(),
    };
  }

  MenuCategory _categoryFromMap(Map<String, dynamic> json) {
    final productsJson = json['products'] as List<dynamic>? ?? const [];

    return MenuCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      products: productsJson.map((value) {
        return _productFromMap(Map<String, dynamic>.from(value as Map));
      }).toList(),
    );
  }

  Map<String, dynamic> _productToMap(Product product) {
    return {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'image': product.imagePath,
    };
  }

  Product _productFromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      imagePath: json['image'] as String?,
    );
  }
}
