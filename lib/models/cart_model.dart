// cart_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  CartModel(this.userId);

  final List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  Future<void> add(ProductModel product) async {
    _items.add(product);
    notifyListeners();
    await _updateFirestoreFavourite();
  }

  Future<void> remove(ProductModel product) async {
    _items.remove(product);
    notifyListeners();
    await _updateFirestoreFavourite();
  }

  Future<void> clear() async {
    _items.clear();
    notifyListeners();
    await _updateFirestoreFavourite();
  }

  Future<void> _updateFirestoreFavourite() async {
    try {
      await _firestore.collection('favourite').doc(userId).set({
        'products': _items.map((product) => product.toMap()).toList(),
      });
    } catch (e) {
      print('Error updating favourite: $e');
    }
  }

  Future<void> loadCart() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('favourite').doc(userId).get();
      if (doc.exists) {
        List<dynamic> productList = doc['products'];
        _items.clear();
        _items.addAll(productList.map((data) => ProductModel.fromMap(data)).toList());
        notifyListeners();
      }
    } catch (e) {
      print('Error loading favourite: $e');
    }
  }
}
