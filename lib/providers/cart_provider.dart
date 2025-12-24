import 'package:flutter/material.dart';import '../models/product_model.dart';
import '../models/cart_item_model.dart';

class CartProvider with ChangeNotifier {

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  void setInventory(Map<String, CartItem> fetchedItems) {
    _items = fetchedItems;
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
            (existingItem) => CartItem(
          id: existingItem.id,
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
            () => CartItem(
          id: DateTime.now().toString(),
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(String productId, bool isIncrement) {
    if (!_items.containsKey(productId)) return;

    if (isIncrement) {
      _items.update(productId, (existing) => existing.copyWith(quantity: existing.quantity + 1));
    } else {
      if (_items[productId]!.quantity > 1) {
        _items.update(productId, (existing) => existing.copyWith(quantity: existing.quantity - 1));
      } else {
        removeItem(productId);
      }
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
