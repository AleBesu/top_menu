class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String? imagePath;
  String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.imageUrl,
  });

  Product copyWith({
    String? name,
    String? description,
    String? price,
    String? imagePath,
    String? imageUrl,
  }) => Product(
    id: id,
    name: name ?? this.name,
    description: description ?? this.description,
    price: price ?? this.price,
    imagePath: imagePath ?? this.imagePath,
    imageUrl: imageUrl ?? this.imageUrl,
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      imagePath: json['imagePath'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      "imageUrl": imageUrl,
    };
  }
}
