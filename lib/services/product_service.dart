import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _productsCollection = FirebaseFirestore.instance.collection('products');

  // Add a new product
  Future<bool?> addProduct(ProductModel product, XFile imgurl) async {
    var url;
    var filename = product.uid;
    try {
      var ref = FirebaseStorage.instance.ref().child('product/$filename');
      UploadTask utask = ref.putFile(File(imgurl!.path));
      TaskSnapshot snapshot = await utask;
      url = await snapshot.ref.getDownloadURL();
      ProductModel _product = ProductModel(
        uid: product.uid,
        title: product.title,
        img: url,
        desc: product.desc,
        category: product.category,

      );
      await _productsCollection.doc(product.uid).set(_product.toMap());
      return true;
    } catch (e) {
      throw Exception("Failed to add product: $e");
    }
  }

  // Update an existing product
  Future<void> updateProduct(String id, ProductModel product) async {
    try {
      await _productsCollection.doc(id).update(product.toMap());
    } catch (e) {
      throw Exception("Failed to update product: $e");
    }
  }

  // Delete a product by id
  Future<void> deleteProduct(String id) async {
    try {
      await _productsCollection.doc(id).delete();
    } catch (e) {
      throw Exception("Failed to delete product: $e");
    }
  }

  // Get a specific product by id
  Future<ProductModel?> getProductById(String id) async {
    try {
      DocumentSnapshot doc = await _productsCollection.doc(id).get();
      if (doc.exists) {
        return ProductModel.fromSnapshot(doc);
      }
      return null;
    } catch (e) {
      throw Exception("Failed to get product: $e");
    }
  }

  // Get a stream of products for real-time updates
  Stream<List<ProductModel>> getProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    });
  }
}
