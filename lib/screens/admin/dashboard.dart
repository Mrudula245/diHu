import 'package:dihub/common/user_register.dart';
import 'package:dihub/screens/admin/guide_info.dart';
import 'package:dihub/screens/admin/user_info.dart';
import 'package:dihub/screens/admin/view_ratings.dart';

import 'package:dihub/screens/technicalguide/guide_register.dart';
import 'package:dihub/services/auth_service.dart';
import 'package:flutter/material.dart';


class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.blue.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.cyan,
            title: Text('Admin Dashboard'),
            leading:  IconButton(onPressed: (){


              AuthService _authService=AuthService();
              _authService.logout().then((value) => Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false));

            }, icon: Icon(Icons.logout)),
            floating: true,
            snap: true,
            centerTitle: true,
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),

                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(

                            context,
                            MaterialPageRoute(builder: (context) =>UserInfo()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          ' User',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the AddBookPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>GuideInfo()), // Replace AddBookPage with your actual page name
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          '  Guide',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the AddBookPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ViewRatingFeedback()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(800, 50),
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          ' Feedback & Ratings',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Readex Pro',
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}