import 'dart:io';

import 'package:dihub/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late Future<UserModel> _userFuture;
  final List<String> _nationalities = ['India', 'USA', 'Japan', 'UAE'];
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adrsController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _infoKey = GlobalKey<FormState>();
  File? _image;
  String? _selectedGender;
  String? _selectedNationality;
  String? _selectedExperienceLevel;

  @override
  void initState() {
    super.initState();
    _userFuture = _getUserData();
  }

  Future<UserModel> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
      UserModel userData = UserModel.fromJoson(userDoc);
      // _selectedGender = userData.gender;
      return userData;
    } else {
      throw Exception("User not logged in");
    }
  }

  Future<void> _selectImage() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,  // Set the Scaffold background color
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Personal Info', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: FutureBuilder<UserModel>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No user data found'));
                  } else {
                    UserModel userData = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: _selectImage,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Color(0xffFFF5E9),
                              child: _image != null
                                  ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                ),
                              )
                                  : Icon(
                                Icons.person,
                                color: Color(0xffD77272),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _infoKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _userController..text = userData.name ?? '',
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Name",
                                  prefixIcon: Icon(Icons.person_3_outlined, color: Colors.blue),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController..text = userData.email ?? '',
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Email",
                                  prefixIcon: Icon(Icons.email_outlined, color: Colors.blue),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: _phoneController..text = userData.phone ?? "",
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Phone no",
                                  prefixIcon: Icon(Icons.phone, color: Colors.blue),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 20),
                              // TextFormField(
                              //   keyboardType: TextInputType.multiline,
                              //   controller: _adrsController..text=userData.address??"",
                              //   cursorColor: Colors.orange,
                              //   decoration: InputDecoration(
                              //     filled: true,
                              //     fillColor: Colors.white,
                              //     hintText: "Address",
                              //     prefixIcon: Icon(
                              //         Icons.location_on, color: Colors.orange),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Colors.grey[300]!, width: 1.2),
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //           color: Colors.orange, width: 1.2),
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: _ageController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "D.O.B",
                                  prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.blue),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[300]!, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue, width: 1.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onTap: () {
                                  _selectDate(context);
                                },
                                readOnly: true,
                              ),
                              SizedBox(height: 20),
                              Text("Gender", style: TextStyle(fontSize: 16)),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: _selectedGender,
                                    activeColor: Colors.orange,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text("Male"),
                                  Radio<String>(
                                    value: 'Female',
                                    activeColor: Colors.orange,
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                  Text("Female"),
                                ],
                              ),
                              SizedBox(height: 20),
                              DropdownButtonFormField<String>(
                                value: _selectedNationality,
                                iconEnabledColor: Colors.blue,
                                hint: Text('Nationality'),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNationality = value;
                                  });
                                },
                                items: _nationalities.map((nationality) {
                                  return DropdownMenuItem(
                                    value: nationality,
                                    child: Text(nationality),
                                  );
                                }).toList(),
                              ),
                              // SizedBox(height: 20),
                              // DropdownButtonFormField<String>(
                              //   value: _selectedExperienceLevel,
                              //   iconEnabledColor: Colors.orange,
                              //   hint: Text('Experience Level'),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       _selectedExperienceLevel = value;
                              //     });
                              //   },
                              //   items: ['Beginner', 'Intermediate', 'Expert']
                              //       .map((experienceLevel) {
                              //     return DropdownMenuItem(
                              //       value: experienceLevel,
                              //       child: Text(experienceLevel),
                              //     );
                              //   }).toList(),
                              // ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _savePersonalInfo,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text('Save Info', style: TextStyle(color: Colors.white, fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _ageController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _savePersonalInfo() {
    if (_infoKey.currentState!.validate()) {
      // Save user info
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Personal information saved successfully!'),
      ));
    }
  }
}
