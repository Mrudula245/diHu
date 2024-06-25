import 'package:dihub/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAppointmentsScreen extends StatefulWidget {
  final String userId;

  ViewAppointmentsScreen({required this.userId});

  @override
  _ViewAppointmentsScreenState createState() => _ViewAppointmentsScreenState();
}

class _ViewAppointmentsScreenState extends State<ViewAppointmentsScreen> {
  // Reference to Firestore collection
  final CollectionReference appointmentsCollection =
  FirebaseFirestore.instance.collection('appointments');

  void _deleteAppointment(String docId) async {
    try {
      await appointmentsCollection.doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Appointment deleted!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete appointment. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmAppointment(String docId, int isConfirmed) async {
    try {
      await appointmentsCollection.doc(docId).update({'status': isConfirmed == 1 ? 0 : 1});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isConfirmed == 1
              ? 'Appointment unconfirmed!'
              : 'Appointment confirmed!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update appointment. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  UserModel? userdata;
  Future<UserModel?> getuserData(String id) async {
    DocumentSnapshot snap =
    await FirebaseFirestore.instance.collection('user').doc(id).get();

    setState(() {
      userdata = UserModel.fromJoson(snap);
    });
    print(userdata);
    return userdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'View Appointments',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: appointmentsCollection
            .where('guideid', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No appointments found.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              DateTime date = (doc['date'] as Timestamp).toDate();
              TimeOfDay time = TimeOfDay(
                hour: int.parse(doc['time'].split(':')[0]),
                minute: int.parse(doc['time'].split(':')[1]),
              );
              int isConfirmed = doc['status'] ?? false;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  onTap: () async {
                    final UserModel? userData = await getuserData(doc['userId'])
                        .then((value) => showDetails(value!));
                  },
                  title: Text(
                    'Date: ${date.toString().substring(0, 10)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Time: ${time.format(context)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isConfirmed == 1
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isConfirmed == 1 ? Colors.green : Colors.grey,
                        ),
                        onPressed: () =>
                            _confirmAppointment(doc.id, isConfirmed),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAppointment(doc.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  showDetails(UserModel user) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(25),
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
        );
      },
    );
  }
}
