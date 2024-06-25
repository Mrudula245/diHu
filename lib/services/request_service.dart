import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/models/request_model.dart';
import 'package:dihub/models/user_model.dart';
import 'package:dihub/models/guide_model.dart';

class RequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRequest(RequestModel request,) async {
    try {
      await _firestore.collection('requests').doc(request.id).set(request.toJson());
    } catch (error) {
      print('Error adding request: $error');
      throw error;
    }
  }

  Future<RequestModel?> getRequestById(String requestId) async {
    try {
      DocumentSnapshot requestSnapshot = await _firestore.collection('requests').doc(requestId).get();
      if (requestSnapshot.exists) {
        return RequestModel.fromJson(requestSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching request data: $error');
      throw error;
    }
  }

  Future<List<RequestModel>> getAllRequests() async {
    try {
      QuerySnapshot requestSnapshot = await _firestore.collection('requests').get();
      return requestSnapshot.docs.map((doc) => RequestModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (error) {
      print('Error fetching requests data: $error');
      throw error;
    }
  }
}
