import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../services/database_service.dart';
import '../widgets/product_card.dart';
import '../utils/constants.dart';
import 'cart_screen.dart';
import 'add_product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final DatabaseService _dbService = DatabaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Borobazar"),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, size: 26),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    return cart.itemCount == 0
                        ? const SizedBox()
                        : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${cart.itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: _dbService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching products"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(
              child: Text(
                "No products found.\nClick + to add some!",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textLight),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.paddingMedium),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
