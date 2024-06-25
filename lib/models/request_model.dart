import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/models/user_model.dart';
import 'package:dihub/models/guide_model.dart';

class RequestModel {
  String?id;
   String ?userId;
   String ?guideId;
  String ?productId;
  var timestamp;
  String ?reply;
  int? status;

  RequestModel({
   this.userId,
  this.guideId,
     this.productId,
    required this.timestamp,
    this.id,this.status,this.reply
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      userId: json['userId'] ?? '',
      guideId: json['guideId'] ?? '',
      productId: json['productId'] ?? '',
      timestamp: json['timestamp'] ?? Timestamp.now(),
      id: json['id'],
      reply: json['reply'],
      status: json['status']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'guideId': guideId,
      'productId': productId,
      'timestamp': timestamp,
      'status':status,
      'id':id,
      'reply':reply
    };
  }
}
