// lib/widgets/app_promotion_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Add this import

class AppPromotionSection extends StatelessWidget {
  const AppPromotionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          const Text(
            "Make your online shop easier\nwith our mobile app",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "BoroBazar makes online grocery shopping fast and easy. "
                "Get groceries delivered and order the best of seasonal farm fresh food.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(
                "https://developer.apple.com/assets/elements/badges/download-on-the-app-store.svg",
                height: 45,
                placeholderBuilder: (context) => const SizedBox(
                  height: 45,
                  width: 135,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.network(
                "https://steverichey.github.io/google-play-badge-svg/img/en_get.svg",  // Updated reliable URL
                height: 65,  // Play badge is taller
                placeholderBuilder: (context) => const SizedBox(
                  height: 65,
                  width: 180,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}