// lib/widgets/horizontal_scroll_arrows.dart

import 'package:flutter/material.dart';

class HorizontalScrollArrows extends StatelessWidget {
  final ScrollController controller;
  final double topOffset;

  const HorizontalScrollArrows({
    super.key,
    required this.controller,
    this.topOffset = 45,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 5,
          top: topOffset,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: const Icon(Icons.chevron_left, size: 20, color: Colors.black87),
              onPressed: () {
                controller.animateTo(
                  controller.offset - 250,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: topOffset,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: const Icon(Icons.chevron_right, size: 20, color: Colors.black87),
              onPressed: () {
                controller.animateTo(
                  controller.offset + 250,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}