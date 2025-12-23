import 'package:cloud_firestore/cloud_firestore.dart';import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Requirement: Add Product to Backend (Firebase Firestore)
        await FirebaseFirestore.instance.collection('products').add({
          'name': _nameController.text.trim(),
          'price': double.parse(_priceController.text.trim()),
          'description': _descController.text.trim(),
          'image_url': _imageController.text.trim(),
          'created_at': FieldValue.serverTimestamp(), // For the orderBy logic in HomeScreen
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Product added successfully!"),
              backgroundColor: AppColors.primary,
            ),
          );
          Navigator.pop(context); // Go back to Home
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: AppColors.error),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Product Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: "e.g. Fresh Organic Apples"),
                validator: (val) => val!.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 20),

              const Text("Price (\$)", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "e.g. 12.50"),
                validator: (val) => val!.isEmpty ? "Enter price" : null,
              ),
              const SizedBox(height: 20),

              const Text("Image URL", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(hintText: "Paste image link here"),
                validator: (val) => val!.isEmpty ? "Enter image URL" : null,
              ),
              const SizedBox(height: 20),

              const Text("Description", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(hintText: "Describe your product..."),
                validator: (val) => val!.isEmpty ? "Enter description" : null,
              ),
              const SizedBox(height: 40),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _submitProduct,
                child: const Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}
