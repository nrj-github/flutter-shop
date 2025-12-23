import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        elevation: 0,
      ),
      body: cart.items.isEmpty
          ? _buildEmptyCart(context)
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.paddingMedium),
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items.values.toList()[index];
                final productId = cart.items.keys.toList()[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.product.imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey[200],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${item.product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          _qtyButton(Icons.remove,
                                  () => cart.updateQuantity(productId, false)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text("${item.quantity}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          _qtyButton(Icons.add,
                                  () => cart.updateQuantity(productId, true)),
                        ],
                      ),
                      const SizedBox(width: 8),

                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: AppColors.error),
                        onPressed: () => cart.removeItem(productId),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          _buildSummary(cart),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: AppColors.textDark),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text("Your cart is empty",
              style: TextStyle(fontSize: 18, color: AppColors.textLight)),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
            onPressed: () => Navigator.pop(context),
            child: const Text("Start Shopping"),
          )
        ],
      ),
    );
  }

  Widget _buildSummary(CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                "\$${cart.totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text("Proceed to Checkout"),
          ),
        ],
      ),
    );
  }
}
