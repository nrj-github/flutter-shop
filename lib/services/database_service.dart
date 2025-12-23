import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    await _db.collection('products').add({
      ...productData,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
