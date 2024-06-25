import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  String? id;
  String? userId;
  String? username; // Adding username field
  String? feedback;
  double? ratings;
  int? status;
  DateTime? timestamp;

  FeedbackModel({
    this.id,
    this.userId,
    this.username,
    this.feedback,
    this.ratings,
    this.status,
    this.timestamp,
  });

  // Convert a FeedbackModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'feedback': feedback,
      'status': status,
      'ratings': ratings,
      'timestamp': timestamp,
    };
  }

  // Create a FeedbackModel from a Map
  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userId: map['userId'],
      username: map['username'],
      feedback: map['feedback'],
      ratings: map['ratings'],
      status: map['status'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
    );
  }
}