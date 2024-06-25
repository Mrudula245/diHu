import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/user_model.dart';
import 'package:dihub/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel _userModel = UserModel();
  bool _isLoading = true;
  String? _userName;
  String? _joinedDate;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _userModel = UserModel.fromJoson(userDoc.data() as DocumentSnapshot<Object?>);
            _userName = _userModel.name;
            _joinedDate = user.metadata.creationTime?.toLocal().toString().split(' ')[0];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        toolbarHeight: 260,
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 16, 0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'personalinfo');
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 50.0, 120.0, 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 50,
                  child: Image.asset(
                    'assets/img/pic.jpeg',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 8),
                _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                  children: [
                    Text(
                      _userName ?? 'Name not available',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Joined: $_joinedDate',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Card(
        child: ListView(
          padding: EdgeInsets.all(5.0),
          children: [
            _buildListItem(Icons.person_outline, "Account", 'personalinfo'),
            SizedBox(height: 5),
            _buildListItem(Icons.history, "History", 'history'),
            SizedBox(height: 5),
            _buildListItem(Icons.privacy_tip_outlined, "Privacy Policy", 'privacy'),
            SizedBox(height: 5),
            _buildListItem(Icons.notifications_outlined, "Notifications", 'recommendation'),
            SizedBox(height: 5),
            _buildListItem(Icons.lock_reset, "Reset Password", 'resetpassword'),
            SizedBox(height: 5),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              title: Text("Log Out"),
              trailing: Icon(Icons.arrow_right, color: Colors.blue),
              onTap: () async {
                await AuthService().logout().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => false));
              },
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text, String route) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: Icon(icon, color: Colors.blue),
        title: Text(text),
        trailing: Icon(Icons.arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
