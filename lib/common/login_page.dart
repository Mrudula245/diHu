import 'package:dihub/common/validator.dart';
import 'package:dihub/screens/admin/register_tab.dart';
import 'package:dihub/common/forgot_password.dart';
import 'package:dihub/screens/user/user_explore.dart';
import 'package:dihub/common/user_register.dart';
import 'package:dihub/services/auth_service.dart';
import 'package:dihub/services/user_service.dart';
import 'package:dihub/widgets/appbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isShowPassword = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _logkey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade900,
          Colors.blue.shade800,
          Colors.blue.shade400,
        ])),
        child: Container(
          child: Form(
            key: _logkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Hello",
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign in!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, 3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        // border:Border(bottom:BorderSide(color:Colors.grey.shade400) )
                                        ),
                                    child: TextFormField(
                                      validator: (value) {
                                        return Validator.validateEmail(value!);
                                      },
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.email_outlined),
                                          suffixIcon: Icon(
                                            Icons.check,
                                            color: Colors.grey,
                                          ),
                                          hintText: "Enter your email ",
                                          label: Text('Gmail ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue.shade900,
                                              ))),
                                    ),
                                  ),
                                  TextFormField(
                                    obscureText: isShowPassword,
                                    validator: (value) {
                                      return Validator.validatePassword(value!);
                                    },
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        label: Text('Password',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue.shade900,
                                            )),
                                        prefixIcon: Icon(Icons.password),
                                        suffixIcon: CupertinoButton(
                                          onPressed: () {
                                            setState(() {
                                              isShowPassword = !isShowPassword;
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            isShowPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          AppButton(
                              onPressed: () async {

                                print("hello jobin");
                                if (_logkey.currentState!.validate()) {
                                  AuthService _authSrvice = AuthService();

                                  final data = await _authSrvice.loginUser(
                                      _emailController.text,
                                      _passwordController.text);

                                  var role = data!['role'];

                                  if (role == 'user') {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,  'userhome', (route) => false);
                                  } else if (role == 'guide') {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, 'guidehome', (route) => false);
                                  } else if (role == 'admin') {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, 'adminhome', (route) => false);
                                  } else {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, 'login', (route) => false);
                                  }
                                }
                              },
                              title: "Login",
                          color: Colors.blue,),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the forgot password page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text("Don't have an account?"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterTab()));
                              },
                              child: Text(
                                "Create an account",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          )

                          //
                          //       ),
                          //     )
                          //   ],
                          // )
                        ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
