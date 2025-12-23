import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../utils/constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();

  final DatabaseService _dbService = DatabaseService();

  bool _isLoading = false;

  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final productData = {
          'name': _nameController.text.trim(),
          'price': double.parse(_priceController.text.trim()),
          'description': _descController.text.trim(),
          'image_url': _imageController.text.trim(),
        };

        await _dbService.addProduct(productData);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Product added successfully!"),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${e.toString()}"),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _imageController.dispose();
    super.dispose();
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
              _buildLabel("Product Name"),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: "e.g. Fresh Organic Apples"),
                validator: (val) => val!.isEmpty ? "Enter product name" : null,
              ),
              const SizedBox(height: 20),

              _buildLabel("Price (\$)"),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(hintText: "e.g. 12.50"),
                validator: (val) {
                  if (val!.isEmpty) return "Enter price";
                  if (double.tryParse(val) == null) return "Enter a valid number";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              _buildLabel("Image URL"),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(hintText: "Paste high-quality image link"),
                validator: (val) => val!.isEmpty ? "Enter image URL" : null,
              ),
              const SizedBox(height: 20),

              _buildLabel("Description"),
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}
