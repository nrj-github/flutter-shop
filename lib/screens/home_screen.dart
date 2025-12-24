// lib/screens/home_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../services/database_service.dart';
import '../utils/constants.dart';
import 'add_product_screen.dart';

import '../widgets/offer_banner.dart';
import '../widgets/language_selector.dart';
import '../widgets/hero_banner.dart';
import '../widgets/offer_cards_section.dart';
import '../widgets/category_section.dart';
import '../widgets/products_grid_section.dart';
import '../widgets/special_offer_banner.dart';
import '../widgets/popular_products_section.dart';
import '../widgets/curated_collections_note.dart';
import '../widgets/curated_collections_section.dart';
import '../widgets/app_promotion_section.dart';
import '../widgets/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _syncCartFromFirebase();
  }

  Future<void> _syncCartFromFirebase() async {
    Future.microtask(() async {
      final remoteCart = await _dbService.getCartItems();
      if (remoteCart.isNotEmpty && mounted) {
        context.read<CartProvider>().setInventory(remoteCart);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 1. OfferBanner - scrolls away (not pinned)
            const SliverToBoxAdapter(
              child: OfferBanner(),
            ),

            // 2. Pinned App Bar - stays at top after OfferBanner scrolls past
            SliverAppBar(
              pinned: true,           // This makes it sticky
              floating: false,
              backgroundColor: Colors.white,
              elevation: 2,
              toolbarHeight: 70,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.shopping_bag, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Borobazar",
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    const LanguageSelector(),
                  ],
                ),
              ),
            ),

            // 3. All remaining content
            SliverToBoxAdapter(child: const HeroBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: OfferCardsSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: CategorySection()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: ProductsGridSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: SpecialOfferBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            const SliverToBoxAdapter(child: PopularProductsSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            const SliverToBoxAdapter(child: CuratedCollectionsNote()),
            const SliverToBoxAdapter(child: CuratedCollectionsSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            const SliverToBoxAdapter(child: AppPromotionSection()),
            const SliverToBoxAdapter(child: FooterSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 80)), // Extra bottom padding
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddProductScreen()),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}