import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/guide_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GuideService{


  Future<bool?> registerUser(GuideModel user) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: user.email.toString(), password: user.password.toString());




      print(user.role);
      final guide=GuideModel(

          role: user.role,
          email:user.email,
          uid: userResponse.user!.uid,
          password:user.password,
          name: user.name, phone: user.phone,status: user.status,

         qualification: user.qualification);

      FirebaseFirestore.instance
          .collection('login')
          .doc(userResponse.user!.uid)
          .set({

        'uid':userResponse.user!.uid,
        'role':guide.role,
        'email':guide.email
      });


      FirebaseFirestore.instance
          .collection('technicalguide')
          .doc(userResponse.user!.uid)
          .set(guide.toMap());

      return true;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      return false; // Return Firebase Auth error message
    } catch (e) {
      print('Error: $e');
      return false; // Return generic error message
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'technicalguide';

  Future<List<GuideModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collectionName).get();

      List<GuideModel> users = querySnapshot.docs
          .map((doc) => GuideModel.fromJoson(doc))
          .toList();

      return users;
    } catch (e) {
      print("Error getting users: $e");
      return []; // or throw an error if needed
    }
  }

}