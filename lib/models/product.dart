class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  Product copyWith({
    String? name,
    String? description,
    String? price,
    String? image,
  }) =>
      Product(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
      );
}
