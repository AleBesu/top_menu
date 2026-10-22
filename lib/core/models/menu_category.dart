import 'product.dart';

class MenuCategory {
  final String id;
  final String name;
  final List<Product> products;

  const MenuCategory({
    required this.id,
    required this.name,
    required this.products,
  });

  MenuCategory copyWith({String? name, List<Product>? products}) =>
      MenuCategory(
        id: id,
        name: name ?? this.name,
        products: products ?? this.products,
      );
}
