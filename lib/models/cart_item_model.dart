import 'product_model.dart';

class CartItem {
  final String id; // Unique ID for the cart entry
  final Product product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
  });

  // Requirement: Total amount (Price * Quantity)
  double get totalValue => product.price * quantity;

  // Used for updating quantity dynamically in the UI
  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  // If you decide to sync the cart to Firebase, use these:
  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'name': product.name,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'quantity': quantity,
    };
  }
}
