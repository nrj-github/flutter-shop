import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';
import '../models/cart_item_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- PRODUCT MANAGEMENT ---

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

  // --- CART MANAGEMENT (Linked with User ID) ---

  CollectionReference? _getUserCartRef() {
    String? uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid).collection('cart');
  }

  Future<void> addToFirestoreCart(CartItem cartItem) async {
    final cartRef = _getUserCartRef();
    if (cartRef != null) {
      await cartRef.doc(cartItem.product.id).set(cartItem.toMap());
    }
  }

  Future<void> removeFromFirestoreCart(String productId) async {
    final cartRef = _getUserCartRef();
    if (cartRef != null) {
      await cartRef.doc(productId).delete();
    }
  }


  Future<Map<String, CartItem>> getCartItems() async {
    final cartRef = _getUserCartRef();
    if (cartRef == null) return {};

    final snapshot = await cartRef.get();
    Map<String, CartItem> fetchedItems = {};

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;

      Product product = Product(
        id: data['productId'] ?? doc.id,
        name: data['name'] ?? 'Unknown Product',
        price: (data['price'] ?? 0).toDouble(),
        imageUrl: data['imageUrl'] ?? '',
        description: '',
      );

      fetchedItems[product.id] = CartItem(
        id: doc.id,
        product: product,
        quantity: data['quantity'] ?? 1,
      );
    }
    return fetchedItems;
  }
}
