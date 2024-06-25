import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/models/request_model.dart';
import '../models/recomentaion_model.dart';

class RecommendationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRecommendation(RequestModel req,String reply) async {
    try {
      await _firestore.collection('requests').doc(req.id).update({

        'reply':reply,
        'status':1
      });
    } catch (e) {
      // Handle errors
      print('Error adding recommendation: $e');
      rethrow;
    }
  }
  Future<ProductModel> getProductData(String id) async {
    DocumentSnapshot? snap =
    await FirebaseFirestore.instance.collection('products').doc(id).get();

    return ProductModel.fromSnapshot(snap);
  }

  Future<List<RequestModel>> getRecommendations(String id) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('requests').where('userId',isEqualTo: id).get();
      return querySnapshot.docs.map((doc) => RequestModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      // Handle errors
      print('Error fetching recommendations: $e');
      rethrow;
    }
  }
}
