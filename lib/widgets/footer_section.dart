// lib/widgets/footer_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Widget footerItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 20),

          // About Us & Our Information
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("About Us", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    footerItem("About us"),
                    footerItem("Contact us"),
                    footerItem("About team"),
                    footerItem("Customer Support"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Our Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    footerItem("Privacy policy update"),
                    footerItem("Terms & conditions"),
                    footerItem("Return Policy"),
                    footerItem("Site Map"),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Community
          const Text("Community", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          footerItem("Announcements"),
          footerItem("Answer center"),
          footerItem("Discussion boards"),
          footerItem("Giving works"),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 20),

          // Subscribe Now
          const Text("Subscribe Now", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            "Subscribe your email for newsletter and featured news based on your interest",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.email_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write your email here",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement subscription logic
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Copyright + Payment Logos ONLY
          Column(
            children: [
              // Copyright
              const Text(
                "© Copyright 2025 REDQ  All rights reserved",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Payment Logos - Smaller & horizontal scrollable if needed
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.network(
                      "https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg",
                      height: 24,
                      placeholderBuilder: (_) => const SizedBox(width: 60, height: 24),
                    ),
                    const SizedBox(width: 14),
                    SvgPicture.network(
                      "https://upload.wikimedia.org/wikipedia/commons/a/ac/Visa_2021.svg",
                      height: 24,
                      placeholderBuilder: (_) => const SizedBox(width: 80, height: 24),
                    ),
                    const SizedBox(width: 14),
                    SvgPicture.network(
                      "https://upload.wikimedia.org/wikipedia/commons/f/fd/PayPal.svg",
                      height: 24,
                      placeholderBuilder: (_) => const SizedBox(width: 100, height: 24),
                    ),
                    const SizedBox(width: 14),
                    SvgPicture.network(
                      "https://upload.wikimedia.org/wikipedia/commons/0/0b/Skrill_logo.svg",
                      height: 24,
                      placeholderBuilder: (_) => const SizedBox(width: 80, height: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}