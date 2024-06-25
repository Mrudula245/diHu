import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/feedback_model.dart';
import '../../models/user_model.dart';

class ViewRatingFeedback extends StatefulWidget {
  @override
  _ViewRatingFeedbackState createState() => _ViewRatingFeedbackState();
}

class _ViewRatingFeedbackState extends State<ViewRatingFeedback> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<FeedbackModel> _feedback = [];
  String? id;

  @override
  void initState() {
    super.initState();
    id = FirebaseAuth.instance.currentUser?.uid;
  }

  Stream<List<FeedbackModel>> getFeedbackStream() {
    return _firestore
        .collection('feedbacks')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => FeedbackModel.fromMap(doc.data()))
        .toList());
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJoson(snapshot);
      } else {
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(
          'Reviews & Feedbacks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<FeedbackModel>>(
          stream: getFeedbackStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              _feedback = snapshot.data ?? [];
              return _buildFeedbackList();
            }
          },
        ),
      ),
    );
  }

  Widget _buildFeedbackList() {
    if (_feedback.isEmpty) {
      return Center(
        child: Text('No feedbacks found.'),
      );
    } else {
      return ListView.builder(
        itemCount: _feedback.length,
        itemBuilder: (context, index) {
          FeedbackModel feedback = _feedback[index];
          return FutureBuilder<UserModel?>(
            future: getUserData(feedback.userId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null) {
                return Center(
                  child: Text('No user data found.'),
                );
              } else {
                UserModel userData = snapshot.data!;
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

                    title: Text(userData.name ?? '',style: TextStyle(color: Colors.white),),


                    subtitle: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('Feedback: ${feedback.feedback ?? ""}',style: TextStyle(color: Colors.white),),
                        Text('Ratings: ${feedback.ratings ?? ""}',style: TextStyle(color: Colors.white),),
                        Text('User Name: ${feedback.username ?? ""}',style: TextStyle(color: Colors.white),),
                        Text('User Phone: ${userData.phone ?? ""}',style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
              ) );
              }
            },
          );
        },
      );
    }
  }
}
