import 'package:dihub/models/user_model.dart';
import 'package:dihub/services/user_service.dart';
import 'package:dihub/widgets/apptext.dart';
import 'package:flutter/material.dart';
// Import your UserService class

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final UserService _userService = UserService(); // Initialize UserService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: AppText(data: "All Users",color: Colors.white,),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _userService.getAllUsers(), // Get all users from service
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<UserModel> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                UserModel user = users[index];
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
                  ),
                ));
              },
            );
          }
        },
      ),
    );
  }

  void _showUserDetailsModal(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(height: 15),
                Divider(height: 1, thickness: 2, color: Colors.blue.shade100),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue),
                    SizedBox(width: 10),
                    Text("Name:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text(user.name.toString()),
                  ],
                ),
                SizedBox(height: 10),
                Divider(height: 1, thickness: 2, color: Colors.blue.shade100),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.blue),
                    SizedBox(width: 10),
                    Text("Email:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text(user.email.toString()),
                  ],
                ),
                SizedBox(height: 10),
                Divider(height: 1, thickness: 2, color: Colors.blue.shade100),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.blue),
                    SizedBox(width: 10),
                    Text("Phone:", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text(user.phone.toString()),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
