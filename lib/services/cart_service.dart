// cart_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/product_model.dart';


class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateFirestoreCart(String userId, List<ProductModel> items) async {
    try {
      await _firestore.collection('favourite').doc(userId).set({
        'products': items.map((product) => product.toMap()).toList(),
      });
    } catch (e) {
      print('Error updating cart: $e');
    }
  }

  Future<List<ProductModel>> loadCart(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('favourite').doc(userId).get();
      if (doc.exists) {
        List<dynamic> productList = doc['products'];
        return productList.map((data) => ProductModel.fromMap(data)).toList();
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
    return [];
  }
}
