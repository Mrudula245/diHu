import 'package:dihub/models/guide_model.dart';
import 'package:dihub/screens/user/Shedule_date.dart';
import 'package:dihub/services/guide_service.dart';
import 'package:dihub/widgets/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GuideList extends StatefulWidget {
  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  final GuideService _guideService = GuideService(); // Initialize GuideService

  var id;
  getdata()async{

    id=await FirebaseAuth.instance.currentUser!.uid;

  }


  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: AppText(data: "All Guides", color: Colors.white,),
      ),
      body: FutureBuilder<List<GuideModel>>(
        future: _guideService.getAllUsers(), // Get all users from service
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<GuideModel> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                GuideModel user = users[index];
                return Card(
                    shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(15),

                ),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                colors: [
                Colors.blue.shade900,
                Colors.blue.shade800,
                Colors.blue.shade400,
                ],
                ),
                ),

                  child: ListTile(

                    title: Text(user.name ?? '',style: TextStyle(color: Colors.white),),
                    subtitle: Text(user.email ?? '',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      _showUserDetailsModal(context, user); // Show user details modal
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.calendar_today,color: Colors.white,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentFormScreen(userId:id ,guide: user,),
                          ),
                        );
                      },
                    ),
                  ),
                ) );
              },
            );
          }
        },
      ),
    );
  }

  void _showUserDetailsModal(BuildContext context, GuideModel user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Guide Details',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                      )
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.blue),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Name: ${user.name ?? ''}', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Email: ${user.email ?? ''}', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Phone: ${user.phone ?? ''}', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.school, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Qualification: ${user.qualification ?? ''}', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ],
              )

          ),
        );
      },
    );
  }
}
