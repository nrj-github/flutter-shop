import 'dart:async';
import 'package:flutter/material.dart';

class OfferBanner extends StatefulWidget {
  const OfferBanner({super.key});

  @override
  State<OfferBanner> createState() => _OfferBannerState();
}

class _OfferBannerState extends State<OfferBanner> {
  Duration _duration = const Duration(hours: 6, minutes: 25, seconds: 38);
  Timer? _timer;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        setState(() => _isVisible = false);
      } else {
        if (mounted) setState(() => _duration -= const Duration(seconds: 1));
      }
    });
  }

  String formatTime(int value) => value.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
      color: const Color(0xFF18B394),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Claim your online FREE Delivery or Shipping today! Expires in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _timeBox(formatTime(_duration.inHours)),
          const Text(" : ", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          _timeBox(formatTime(_duration.inMinutes % 60)),
          const Text(" : ", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          _timeBox(formatTime(_duration.inSeconds % 60)),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => setState(() => _isVisible = false),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _timeBox(String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}
