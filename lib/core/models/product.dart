class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String? imagePath;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  Product copyWith({
    String? name,
    String? description,
    String? price,
    String? image,
  }) => Product(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    imagePath: image ?? this.imagePath,
  );
}
