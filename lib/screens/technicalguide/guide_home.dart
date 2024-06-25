import 'package:dihub/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class GuideHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar:BottomNavBar(),
      backgroundColor: Colors.blueAccent,
      // appBar: AppBar(
      //   title: Text('Welcome to Gadget Guide'),
      // ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              'Welcome to User Guide!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 20.0),
            Image.asset(
              'assets/img/onboard.png', // Replace with your image asset
              height: 200.0,
            ),

            SizedBox(height: 20.0),
            ElevatedButton(

              onPressed: () {
                // Navigate to the next screen (e.g., HomeScreen)
                Navigator.pushNamed(context, 'dashboard');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
