import 'dart:async';
import 'dart:ui';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_menu/app/app_colors.dart';
import 'package:top_menu/core/datasourses/hive_restaurant_local_data_source.dart';
import 'package:top_menu/core/models/menu_category.dart';
import 'package:top_menu/core/models/product.dart';
import 'package:top_menu/core/models/restaurant_config.dart';
import 'package:top_menu/core/models/restaurant_config_repository.dart';
import 'package:top_menu/core/repository/restaurant_local_datasource.dart';
import 'package:top_menu/core/services/file_handle/file_handle.dart';
import 'package:top_menu/core/utils.dart';

// ── Inyección de dependencias

final menuConfigProvider =
    NotifierProvider<RestaurantNotifier, RestaurantConfig>(
      RestaurantNotifier.new,
    );

final _restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dataSource = HiveRestaurantLocalDataSource();

  return HiveRestaurantRepository(dataSource);
});

// ── Estado del restaurante

class RestaurantNotifier extends Notifier<RestaurantConfig> {
  Future<void> _writeQueue = Future<void>.value();

  RestaurantRepository get _repository =>
      ref.read(_restaurantRepositoryProvider);

  @override
  RestaurantConfig build() {
    final repository = _repository;
    final savedConfig = repository.getConfig();

    if (savedConfig != null) {
      return savedConfig;
    }

    return RestaurantConfig(
      name: '',
      bannerPath: null,
      openTime: '08:00',
      closeTime: '22:00',
      categories: [],
      address: null,
      isDarkTheme: true,
      numberPhone: null,
      primaryColor: AppColors.primary,
    );
  }

  // ── Persistencia

  void _persist() {
    _persistSnapshot(state);
  }

  void _persistSnapshot(RestaurantConfig snapshot) {
    final repository = _repository;

    // Mantiene las escrituras en orden para que una actualización
    // anterior no termine sobrescribiendo otra más reciente.
    _writeQueue = _writeQueue.then((_) async {
      try {
        await repository.saveConfig(snapshot);
      } catch (error, stackTrace) {
        debugPrint('Error guardando la configuración: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
    });
  }

  Future<void> clearSavedConfig() async {
    await _writeQueue;
    await _repository.deleteConfig();
  }

  // ── General

  void setName(String value) {
    state = state.copyWith(name: value);
    _persist();
  }

  void setBanner(String value) {
    state = state.copyWith(bannerPath: value);
    _persist();
  }

  void setOpenTime(String value) {
    state = state.copyWith(openTime: value);
    _persist();
  }

  void setCloseTime(String value) {
    state = state.copyWith(closeTime: value);
    _persist();
  }

  void setPrimaryColor(Color value) {
    state = state.copyWith(primaryColor: value);
    _persist();
  }

  // ── Categorías

  void addCategory(MenuCategory newCategory) {
    state = state.copyWith(categories: [...state.categories, newCategory]);
    _persist();
  }

  void renameCategory(String id, String name) {
    _mapCategory(id, (category) => category.copyWith(name: name));
  }

  void deleteCategory(String id) {
    state = state.copyWith(
      categories: state.categories
          .where((category) => category.id != id)
          .toList(),
    );
    _persist();
  }

  // ── Productos

  void saveProduct(String categoryId, Product product) {
    _mapCategory(categoryId, (category) {
      final exists = category.products.any((p) => p.id == product.id);

      //save product image in app documents directory

      return category.copyWith(
        products: exists
            ? [
                for (final currentProduct in category.products)
                  if (currentProduct.id == product.id)
                    product
                  else
                    currentProduct,
              ]
            : [...category.products, product],
      );
    });
  }

  void deleteProduct(String categoryId, String productId) {
    _mapCategory(
      categoryId,
      (category) => category.copyWith(
        products: category.products
            .where((product) => product.id != productId)
            .toList(),
      ),
    );
  }

  // ── Utilidad

  void _mapCategory(String id, MenuCategory Function(MenuCategory) transform) {
    state = state.copyWith(
      categories: [
        for (final category in state.categories)
          if (category.id == id) transform(category) else category,
      ],
    );

    _persist();
  }
}

// ── Configuración inicial de ejemplo
