

import 'package:dihub/common/validator.dart';
import 'package:dihub/services/auth_service.dart';
import 'package:flutter/material.dart';

class GuideProfile extends StatefulWidget {
  const GuideProfile({Key? key}) : super(key: key);

  @override
  State<GuideProfile> createState() => _GuideProfileState();
}

class _GuideProfileState extends State<GuideProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
                title: Text('Account',style: TextStyle(color: Colors.white),),
                toolbarHeight: 260,
        actions: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 16, 0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/personalinfo');
                  // Handle the edit action here
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
                Text(

                  'name', // Replace with user's name
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Joined: month day, year', // Replace with joined date
                  style: TextStyle(
                    color: Colors.grey,
                  ),
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
            _buildListItem(Icons.person_outline, "Account", 'guideprofile'),
            SizedBox(
              height: 5,
            ),

            _buildListItem(
                Icons.privacy_tip_outlined, "Privacy Policy", 'privacypolicy'),
            SizedBox(
              height: 5,
            ),

            _buildListItem(
                Icons.lock_reset, "Reset Password", '/resetpassword'),
            SizedBox(
              height: 5,
            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(
                Icons.logout,
              ),
              title: Text(
                "Log Out",
              ),
              trailing: Icon(Icons.arrow_right),
              onTap: () async {
                await AuthService().logout().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false));
              },
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text, String route) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // You can change the border color here
          width: 0.2, // You can adjust the border width here
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: Icon(icon),
        title: Text(text),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}