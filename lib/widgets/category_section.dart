// lib/widgets/category_section.dart
import 'package:flutter/material.dart';
import '../data/category_data.dart';
import 'horizontal_scroll_arrows.dart';
import 'section_title.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Column(
      children: [
        const SectionTitle(
          title: "What food you love to order",
          subtitle: "Here order your favorite foods from different categories",
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 130,
          child: Stack(
            children: [
              ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5F7FA),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Image.network(cat['img']!, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['name']!,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
              HorizontalScrollArrows(controller: controller, topOffset: 25),
            ],
          ),
        ),
      ],
    );
  }
}