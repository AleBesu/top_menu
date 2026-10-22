import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils.dart';
import '../models/menu_category.dart';
import '../models/product.dart';
import '../models/restaurant_config.dart';

class RestaurantNotifier extends Notifier<RestaurantConfig> {
  @override
  RestaurantConfig build() => _initial();

  // ── General
  void setName(String v) => state = state.copyWith(name: v);
  void setBanner(String v) => state = state.copyWith(banner: v);
  void setOpenTime(String v) => state = state.copyWith(openTime: v);
  void setCloseTime(String v) => state = state.copyWith(closeTime: v);

  // ── Categorías
  void addCategory() => state = state.copyWith(categories: [
        ...state.categories,
        MenuCategory(id: uid(), name: 'Nueva categoría', products: const []),
      ]);

  void renameCategory(String id, String name) =>
      _mapCategory(id, (c) => c.copyWith(name: name));

  void deleteCategory(String id) => state = state.copyWith(
        categories: state.categories.where((c) => c.id != id).toList(),
      );

  // ── Productos
  void saveProduct(String catId, Product product) =>
      _mapCategory(catId, (c) {
        final exists = c.products.any((p) => p.id == product.id);
        return c.copyWith(
          products: exists
              ? [for (final p in c.products) p.id == product.id ? product : p]
              : [...c.products, product],
        );
      });

  void deleteProduct(String catId, String productId) => _mapCategory(
        catId,
        (c) => c.copyWith(
          products: c.products.where((p) => p.id != productId).toList(),
        ),
      );

  void _mapCategory(String id, MenuCategory Function(MenuCategory) fn) {
    state = state.copyWith(categories: [
      for (final c in state.categories) c.id == id ? fn(c) : c,
    ]);
  }
}

final restaurantProvider =
    NotifierProvider<RestaurantNotifier, RestaurantConfig>(
  RestaurantNotifier.new,
);

RestaurantConfig _initial() => RestaurantConfig(
      name: 'La Trattoria',
      banner:
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&h=400&fit=crop&auto=format',
      openTime: '12:00',
      closeTime: '23:00',
      categories: [
        MenuCategory(id: uid(), name: 'Entrantes', products: [
          Product(
            id: uid(),
            name: 'Bruschetta al pomodoro',
            description:
                'Pan tostado con tomate fresco, albahaca y aceite de oliva virgen.',
            price: '6.50',
            image:
                'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400&h=300&fit=crop&auto=format',
          ),
        ]),
        MenuCategory(id: uid(), name: 'Pizzas', products: [
          Product(
            id: uid(),
            name: 'Margherita',
            description: 'Salsa de tomate, mozzarella fior di latte y albahaca.',
            price: '12.00',
            image:
                'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=400&h=300&fit=crop&auto=format',
          ),
          Product(
            id: uid(),
            name: 'Diavola',
            description:
                'Salsa de tomate, mozzarella, salami picante y guindilla.',
            price: '14.00',
            image:
                'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&h=300&fit=crop&auto=format',
          ),
        ]),
      ],
    );
