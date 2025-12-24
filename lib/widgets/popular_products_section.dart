// lib/widgets/popular_products_section.dart
import 'package:flutter/material.dart';
import 'section_title.dart';
import '../widgets/snacks_grid.dart';

class PopularProductsSection extends StatelessWidget {
  const PopularProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionTitle(
          title: "Popular product that we sold",
          subtitle: "We provide best quality & fresh grocery items near your location",
        ),
        SizedBox(height: 20),
        SnacksGrid(),
      ],
    );
  }
}