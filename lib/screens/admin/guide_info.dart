import 'package:dihub/models/guide_model.dart';
import 'package:dihub/models/user_model.dart';
import 'package:dihub/services/guide_service.dart';
import 'package:dihub/services/user_service.dart';
import 'package:dihub/widgets/apptext.dart';
import 'package:flutter/material.dart';
// Import your UserService class

class GuideInfo extends StatefulWidget {
  @override
  _GuideInfoState createState() => _GuideInfoState();
}

class _GuideInfoState extends State<GuideInfo> {
  final GuideService _guideService = GuideService(); // Initialize UserService

  @override
  Widget build(BuildContext context) {
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
                      _showUserDetailsModal(
                          context, user); // Show user details modal
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

  void _showUserDetailsModal(BuildContext context, GuideModel user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Guide Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 20),
              _buildDetailRow('Name', user.name ?? ''),
              _buildDetailRow('Email', user.email ?? ''),
              _buildDetailRow('Phone', user.phone ?? ''),
              _buildDetailRow('Role', user.role ?? ''),
              _buildDetailRow('Qualification', user.qualification ?? ''),
              // Add more user details fields as needed
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                    _showApprovalAlert(context);
                  },
                  child: Text(
                    'Approve',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _showApprovalAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Approval'),
          content: Text('The guide has been approved successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}