import 'package:flutter/material.dart';

class ScrollArrow extends StatelessWidget {
  final ScrollController controller;
  final double top;
  final bool isLeft;

  const ScrollArrow({
    super.key,
    required this.controller,
    required this.top,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeft ? 5 : null,
      right: !isLeft ? 5 : null,
      top: top,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white.withOpacity(0.9),
        child: IconButton(
          icon: Icon(
            isLeft ? Icons.chevron_left : Icons.chevron_right,
            size: 20,
            color: Colors.black87,
          ),
          onPressed: () {
            controller.animateTo(
              isLeft ? controller.offset - 250 : controller.offset + 250,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
