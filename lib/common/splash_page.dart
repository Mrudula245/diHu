import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthService _authService = AuthService();
  bool isLogin = false;
  var role;

  checkLogin() async {
    isLogin = await _authService.isLoggedIn();

    if (isLogin == true) {
      if (role == 'user') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'userhome', (route) => false);
      } else if (role == 'guide') {
        Navigator.pushNamedAndRemoveUntil(context, 'guidehome', (route) => false);
      } else if (role == 'admin') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'adminhome', (route) => false);
      }

      else if (role == 'manager') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'managerhome', (route) => false);
      }


      else {
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      }
    }else {
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }
  }

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    role = await _pref.getString('role');
  }

  @override
  void initState() {
    getData();
    Future.delayed(Duration(seconds:5), () {
      checkLogin();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Container(
          width: 120, // Adjust the width as needed
          height: 120, // Adjust the height as needed
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding as needed
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/img/newlogo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}