import 'package:cloud_firestore/cloud_firestore.dart';

class GuideModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String?phone;
  String?qualification;
  String? role;
  int? status;
  DateTime? createdAt;

  GuideModel(
      {this.uid,
        this.name,
        this.email,
        this.password,
        this.createdAt,
        this.status,
        this.qualification,
        this.phone,
        this.role});



  // fromJson
// Convert DocumentSnapshot to UserModel object
  factory GuideModel.fromJoson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return GuideModel(
      uid: doc.id,
      qualification: data['qualification'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: data['role'],
      phone: data['phone'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert UserModel object to Map
  Map<String, dynamic> toMap() {
    return {
      'qualification':qualification,
      'uid':uid,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'status': status,
      'phone':phone,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }




// toMap



}