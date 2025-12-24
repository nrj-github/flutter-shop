import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'product_card.dart';

class SnacksGrid extends StatelessWidget {
  const SnacksGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Local list of snack products
    final List<Product> snackItems = [
      Product(
        id: 'chip1',
        name: 'Classic Potato Chips',
        price: 3.99,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/69/Potato-Chips.jpg',
        description: 'Crispy salted potato chips.',
      ),
      Product(
        id: 'chip2',
        name: 'Coke & Chips Combo',
        price: 4.50,
        imageUrl: 'https://images.pexels.com/photos/4109134/pexels-photo-4109134.jpeg?w=400',
        description: 'Chilled soft drink served with crispy snacks.',
      ),
      Product(
        id: 'chip3',
        name: 'Fried Rice Snack',
        price: 4.20,
        imageUrl: 'https://images.pexels.com/photos/4110251/pexels-photo-4110251.jpeg?w=400',
        description: 'Freshly cooked white rice served as a staple meal.',
      ),
      Product(
        id: 'chip4',
        name: 'Nacho Cheese Special',
        price: 4.99,
        imageUrl: 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?w=400',
        description: 'Cheesy Mexican style nachos.',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Important for nesting
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: snackItems.length,
      itemBuilder: (context, index) {
        return ProductCard(product: snackItems[index]);
      },
    );
  }
}
