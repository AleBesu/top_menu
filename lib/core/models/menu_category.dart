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

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>? ?? [])
          .map(
            (product) =>
                Product.fromJson(Map<String, dynamic>.from(product as Map)),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
