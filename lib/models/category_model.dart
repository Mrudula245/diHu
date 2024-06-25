import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
   String? title;

   String ?status;

   String? imgPath;

  CategoryModel({
     this.id,
     this.title,
     this.status,

     this.imgPath
  });

  factory CategoryModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      title: data['title'] ,

      status: data['status'] ,
      imgPath: data['imgPath'] ,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,

      'status': status,

      'imgPath': imgPath,
    };
  }
}
