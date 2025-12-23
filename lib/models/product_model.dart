class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final DateTime? createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.createdAt,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      // Ensures price is always a double even if stored as an int in Firebase
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['image_url'] ?? '',
      // This handles missing created_at fields safely
      createdAt: data['created_at'] != null
          ? (data['created_at'] is String
          ? DateTime.tryParse(data['created_at'])
          : (data['created_at'] as dynamic).toDate())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'created_at': DateTime.now().toIso8601String(),
    };
  }
}
