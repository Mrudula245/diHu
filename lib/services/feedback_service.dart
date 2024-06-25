import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/feedback_model.dart';

class FeedbackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new feedback document to Firestore
  Future<void> addFeedback(FeedbackModel feedback) async {
    try {
      await _firestore.collection('feedbacks').add(feedback.toMap());
      print('Feedback added successfully!');
    } catch (e) {
      print('Error adding feedback: $e');
      throw e; // Throw the error for handling in UI if needed
    }
  }

  // Fetch all feedback documents from Firestore as a stream
  Stream<List<FeedbackModel>> getFeedbackStream() {
    return _firestore
        .collection('feedbacks')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => FeedbackModel.fromMap(doc.data())).toList());
  }

  // Update an existing feedback document in Firestore
  Future<void> updateFeedback(FeedbackModel feedback) async {
    try {
      await _firestore.collection('feedbacks').doc(feedback.id).update(feedback.toMap());
      print('Feedback updated successfully!');
    } catch (e) {
      print('Error updating feedback: $e');
      throw e; // Throw the error for handling in UI if needed
    }
  }

  // Delete a feedback document from Firestore
  Future<void> deleteFeedback(String feedbackId) async {
    try {
      await _firestore.collection('feedbacks').doc(feedbackId).delete();
      print('Feedback deleted successfully!');
    } catch (e) {
      print('Error deleting feedback: $e');
      throw e; // Throw the error for handling in UI if needed
    }
  }

  // Fetch a single feedback document from Firestore

  }

