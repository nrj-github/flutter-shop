// lib/widgets/curated_collections_section.dart
import 'package:flutter/material.dart';
import 'horizontal_scroll_arrows.dart';

class CuratedCollectionsSection extends StatelessWidget {
  const CuratedCollectionsSection({super.key});

  final List<Map<String, String>> collections = const [
    {
      "image": "https://images.pexels.com/photos/958545/pexels-photo-958545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Authentic Japanese Cuisine",
      "desc": "Experience the real taste of traditional Japanese dishes made with fresh ingredients"
    },
    {
      "image": "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Healthy Meal Prep Ideas",
      "desc": "Fresh, nutritious meals perfect for busy weeks and healthy living"
    },
    {
      "image": "https://images.pexels.com/photos/1098595/pexels-photo-1098595.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Italian Pasta Classics",
      "desc": "Handmade pasta with rich sauces and premium imported ingredients"
    },
    {
      "image": "https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Fresh Organic Salads",
      "desc": "Farm-fresh greens and vegetables for light and healthy eating"
    },
    {
      "image": "https://images.pexels.com/photos/264636/pexels-photo-264636.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Gourmet Breakfast Selection",
      "desc": "Start your day right with premium breakfast and brunch options"
    },
    {
      "image": "https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Exotic Fruit Basket",
      "desc": "Rare and seasonal tropical fruits delivered fresh to your door"
    },
    {
      "image": "https://images.pexels.com/photos/566566/pexels-photo-566566.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Artisan Bakery Collection",
      "desc": "Freshly baked breads, pastries, and sourdough from local bakers"
    },
    {
      "image": "https://images.pexels.com/photos/2280545/pexels-photo-2280545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Premium Coffee & Tea",
      "desc": "Single-origin beans and rare tea blends for the perfect brew"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    return SizedBox(
      height: 240, // Slightly increased for better text visibility
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final item = collections[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        item["image"]!,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 140,
                            color: Colors.grey[200],
                            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item["desc"]!,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          HorizontalScrollArrows(controller: controller, topOffset: 80),
        ],
      ),
    );
  }
}