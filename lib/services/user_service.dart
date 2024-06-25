import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<bool?> registerUser(UserModel user) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email.toString(), password: user.password.toString());
      final uid = userResponse.user!.uid;

      UserModel usermodel = UserModel(
          name: user.name,
          email: user.email,
          phone: user.phone,
          password: user.password,
          role: user.role,
          status: 1,
          isAdmin: false,
          uid: uid);

      FirebaseFirestore.instance.collection('login').doc(uid).set({
        'email': user.email,
        'password': user.password,
        'uid': uid,
        'role': user.role
      });

      FirebaseFirestore.instance
          .collection('user')
          .doc(userResponse.user!.uid)
          .set(usermodel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot> loginUser(String? email, String password) async {
    UserCredential userData = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: email.toString(), password: password.toString());
    final userSnap = await FirebaseFirestore.instance
        .collection('user')
        .doc(userData!.user!.uid)
        .get();
    var token = await userData.user!.getIdToken();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('name', userSnap['name']);
    _pref.setString('email', userSnap['email']);
    _pref.setString('phone', userSnap['phone']);
    _pref.setString('role', userSnap['role']);
    _pref.setString('token', token!);

    await _pref.clear();

    return userSnap;
  }

  Future<void> logout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.clear();
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = await pref.getString('token');
    if (_token == null) {
      return false;
    } else {
      return true;
    }
  }


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'user';

  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collectionName).get();

      List<UserModel> users = querySnapshot.docs
          .map((doc) => UserModel.fromJoson(doc))
          .toList();

      return users;
    } catch (e) {
      print("Error getting users: $e");
      return []; // or throw an error if needed
    }
  }
}
