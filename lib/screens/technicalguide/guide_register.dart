import 'package:dihub/models/guide_model.dart';
import 'package:dihub/services/guide_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class GuideRegister extends StatefulWidget {
  const GuideRegister({super.key});

  @override
  State<GuideRegister> createState() => _GuideRegisterState();
}

class _GuideRegisterState extends State<GuideRegister> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _qualifiController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController =TextEditingController();
  // bool visible = true;
  // bool isAdmin = false;
  final _signupKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _qualifiController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    // TODO: implement dispose
    super.dispose();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Colors.blue.shade900,
        Colors.blue.shade800,
        Colors.blue.shade400,
        ]
    )
    ),
          child: Form(
            key: _signupKey,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40,),
                Padding(padding: EdgeInsets.all(20),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Create your account",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome!",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                ),
                SizedBox(
                  height: 10,
                ),

                Expanded(
                    child:Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(60)),
                      ),
                      child: Padding(padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a valid Name";
                                }
                              },
                              controller: _nameController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Enter your Name",
                                  label: Text(
                                    'Fullname',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  )),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a valid email";
                                }
                              },
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.keyboard),
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
                            TextFormField(
                              // obscureText: isShowPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a valid password min 6";
                                }
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                label: Text('Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    )),
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter a phone number min 10";
                                }
                              },
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  suffixIcon: Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  label: Text('Phone',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue.shade900,
                                      ))),
                            ),
                            TextFormField(
                              controller:_dateController,
                              readOnly:true ,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month),

                                  suffixIcon: IconButton(onPressed: ()async {
                                    final DateTime ?_date= await showDatePicker(context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025).add(Duration(days: 365))
                                    );
                                    final _formatteddate=DateFormat("dd-MM-yyyy").format(_date!);
                                    print(_formatteddate);


                                    setState(() {
                                      _dateController.text=_formatteddate.toString();
                                    });
                                    print(_date);
                                  },
                                    icon: Icon(Icons.calendar_month),
                                  ),
                                  label: Text('Date of Birth',style: TextStyle(fontWeight:FontWeight.bold,
                                    color: Colors.blue.shade900,
                                  ),


                                  )
                              ),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your qualification ";
                                }
                              },
                              controller: _qualifiController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.keyboard_alt_outlined),
                                  suffixIcon: Icon(
                                    Icons.check,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Enter your qualification",
                                  label: Text(
                                    'Qualification',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900,
                                    ),
                                  )),
                            ),

                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.blue.shade900),
                                ),
                                  onPressed: ()  async{
                                    if (_signupKey.currentState!.validate()) {
                                      GuideModel user = GuideModel(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        phone: _phoneController.text.trim(),
                                        password: _passwordController.text,
                                        qualification: _qualifiController.text,
                                        role: "guide",
                                        status: 1,

                                      );


                                      GuideService _guideService= GuideService();
                                      final bool? res=await _guideService.registerUser(user);



                                      if(res==true){



                                        Navigator.pushNamedAndRemoveUntil(context,'login', (route) => false);
                                      }

                                    }
                                  },
                                  child: Text("SIGN UP",style: TextStyle(color: Colors.white),))),
                          ],
                        ),
                      ),
                      ),
                    ),
                )
              ]),
          ),
        ),
    );
  }
}

