import 'package:top_menu/core/utils.dart';

import 'product.dart';

class MenuCategory {
  final String id;
  final String name;
  final List<Product> products;

  MenuCategory({String? id, required this.name, this.products = const []})
    : id = id ?? uid();

  MenuCategory copyWith({String? name, List<Product>? products}) =>
      MenuCategory(
        id: id,
        name: name ?? this.name,
        products: products ?? this.products,
      );
}
