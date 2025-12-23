import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _localQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.name),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported, size: 80, color: Colors.grey[300]),
                    const Text("Image not available", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text("Select Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildQtyBtn(Icons.remove, () {
                        if (_localQuantity > 1) setState(() => _localQuantity--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("$_localQuantity", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      _buildQtyBtn(Icons.add, () => setState(() => _localQuantity++)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Product Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textLight,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.paddingMedium),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              final cart = context.read<CartProvider>();
              for (int i = 0; i < _localQuantity; i++) {
                cart.addItem(widget.product);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${widget.product.name} added to cart"),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Add to Cart"),
          ),
        ),
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: AppColors.textDark),
      ),
    );
  }
}
