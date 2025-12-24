// lib/widgets/products_grid_section.dart
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/database_service.dart';
import '../widgets/product_card.dart';
import 'section_title.dart';

class ProductsGridSection extends StatelessWidget {
  const ProductsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dbService = DatabaseService();

    return Column(
      children: [
        const SectionTitle(
          title: "Best seller grocery near you",
          subtitle: "we provide best quality & fresh grocery items near your location",
        ),
        const SizedBox(height: 16),
        StreamBuilder<List<Product>>(
          stream: dbService.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final products = snapshot.data ?? [];
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          },
        ),
      ],
    );
  }
}