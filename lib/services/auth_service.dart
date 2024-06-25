import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot?> loginUser(String? email, String password) async {
    try {
      UserCredential userData = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      DocumentSnapshot userSnapshot =
          await _firestore.collection('login').doc(userData.user!.uid).get();

      String role = userSnapshot['role'];
      var token = await userData.user!.getIdToken();
      print(role);
      DocumentSnapshot? userDoc;

      switch (role) {
        case "guide":
          userDoc = await _firestore
              .collection('technicalguide')
              .doc(userData.user!.uid)
              .get();
          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.setString('token', token!);
          _pref.setString('name', userDoc['name']);
          _pref.setString('email', userDoc['email']);
          _pref.setString('phone', userDoc['phone']);
          _pref.setString('role', userDoc['role']);

          break;
        case "user":
          userDoc =
              await _firestore.collection('user').doc(userData.user!.uid).get();

          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.setString('token', token!);
          _pref.setString('name', userDoc['name']);
          _pref.setString('email', userDoc['email']);
          _pref.setString('phone', userDoc['phone']);
          _pref.setString('role', userDoc['role']);

          break;

        case "admin":
          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.setString('token', token!);
          _pref.setString('name', "Admin");
          _pref.setString('email',"email");
          _pref.setString('phone',"985663498");
          _pref.setString('role', userSnapshot!['role']);
          break;
        default:
          throw Exception("Unknown role");
      }





  if(role=='admin'){
    return userSnapshot;
  }
      return userDoc;
    } catch (e) {
      // Handle authentication errors
      print("Error logging in: $e");
      rethrow;
    }
  }
  Future<void> resetPassword(String email) async {
    try {
      // Check if the user is currently signed in
      if (_auth.currentUser == null) {
        // If not signed in, prompt the user to log in again
        throw FirebaseAuthException(
          code: 'requires-recent-login',
          message: 'This operation requires recent authentication. Please log in again.',
        );
      }

      // Send password reset email
      await _auth.sendPasswordResetEmail(email: email);

      // Fetch user document by email
      QuerySnapshot userQuery = await _firestore
          .collection('login')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;
        String userId = userDoc.id;
        String role = userDoc['role'];

        // Log the password reset request in Firestore
        await _firestore.collection('password_resets').add({
          'userId': userId,
          'email': email,
          'timestamp': FieldValue.serverTimestamp(),
          'status': 'requested',
        });

        // Update user document if needed
        if (role == 'user' || role == 'guide') {
          await _firestore.collection(role == 'user' ? 'user' : 'technicalguide').doc(userId).update({
            'passwordResetRequested': FieldValue.serverTimestamp(),
          });
        } else if (role == 'admin') {
          // Example of updating an admin record if needed
          await _firestore.collection('admin').doc(userId).update({
            'passwordResetRequested': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      print("Error resetting password: $e");
      throw e;
    }
  }

  Future<void> logout() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.clear();
    await _auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = pref.getString('token');
    return _token != null;
  }


}
