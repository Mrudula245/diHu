import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
   String ?uid;
   String? title;
   String? desc;
  final String img;
  String?category;
  String ?guideId;
  int? status;
  DateTime ?createdAt;

  ProductModel({
    this.uid,
    this.title,
    this.desc,
    required this.img,
    this.category,this.guideId,this.status,this.createdAt
  });

  // Convert a ProductModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'desc': desc,
      'img': img,
      'category':category,
      'guideId':guideId,
      'status':status
    };
  }

  // Create a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      uid: map['uid'] ?? '',
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      img: map['img'] ?? '',
      category:map['category'],
       status:map['status'],
    guideId:map['guideId']);
  }

  // Create a ProductModel from a Firestore DocumentSnapshot
  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel.fromMap(data);
  }
}
