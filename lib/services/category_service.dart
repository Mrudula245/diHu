import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/category_model.dart';
import 'package:dihub/models/product_model.dart';

import 'package:uuid/uuid.dart';
//
// class CategoryService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collectionName = 'categories';
//
//   Future<void> addCategory(CategoryModel category) async {
//     final List<Map<String, String>> _categories = [];
//     try {
//       await _firestore.collection(_collectionName).doc(category.id).set({
//         'title': category.title,
//
//
//         'status': category.status,
//         'createdAt': category.createdAt,
//         'img': "",
//         'id': category.id,
//         'updatedAt':category.createdAt
//       });
//     } catch (e) {
//       print("Error adding products: $e");
//     }
//     List<Map<String, String>> getCategories() {
//       return _categories;
//     }
//   }
//
//   Future<void> updateCategory(CategoryModel category) async {
//     try {
//       await _firestore
//           .collection(_collectionName)
//           .doc(category.title) // Assuming title is unique
//           .update(category.toMap());
//     } catch (e) {
//       print("Error updating categories: $e");
//     }
//   }
//
//   Future<void> deleteCategory(String title) async {
//     try {
//       await _firestore.collection(_collectionName).doc(title).delete();
//     } catch (e) {
//       print("Error deleting categories: $e");
//     }
//   }
//
//   Stream<List<CategoryModel>> getCategory(String uid) {
//     try {
//       return _firestore.collection(_collectionName).where('uid',isEqualTo:uid ).snapshots().map(
//               (snapshot) => snapshot.docs
//               .map((doc) => CategoryModel.fromJson(doc.data()))
//               .toList());
//     } catch (e) {
//       print("Error getting categories: $e");
//       return Stream.empty();
//     }
//   }
//
//
//
//
//
//   Future<List<ProductModel>> getAllCategoryUser(String uid) async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection(_collectionName)
//           .where('uid', isEqualTo: uid)
//           .get();
//
//       List<ProductModel> categories = querySnapshot.docs
//           .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>))
//           .toList();
//
//       return categories;
//     } catch (e) {
//       print("Error getting categories: $e");
//       return []; // or throw an error if needed
//     }
//   }
//
// }

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _categoriesCollection =
  FirebaseFirestore.instance.collection('categories');

  // Add a new category
  Future<void> addCategory(CategoryModel category) async {
    try {
      String categoryId = Uuid().v4(); // Generate a unique ID
      await _categoriesCollection.doc(categoryId).set({
        'id': categoryId,
        'title': category.title,
        // Other fields can be added here if needed
      });
    } catch (e) {
      throw Exception("Failed to add category: $e");
    }
  }

  // Update an existing category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _categoriesCollection.doc(category.id).update(category.toMap());
    } catch (e) {
      throw Exception("Failed to update category: $e");
    }
  }

  // Delete a category by id
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _categoriesCollection.doc(categoryId).delete();
    } catch (e) {
      throw Exception("Failed to delete category: $e");
    }
  }
  Stream<List<CategoryModel>> getCategories() {
    return _categoriesCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  }
