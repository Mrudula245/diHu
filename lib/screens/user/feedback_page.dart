// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dihub/models/feedback_model.dart';
// import 'package:dihub/models/user_model.dart';
// import 'package:dihub/services/feedback_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:uuid/uuid.dart';
//
// class FeedbackPage extends StatefulWidget {
//   const FeedbackPage({Key? key}) : super(key: key);
//
//   @override
//   State<FeedbackPage> createState() => _FeedbackPageState();
// }
//
// class _FeedbackPageState extends State<FeedbackPage> {
//   FeedbackService _feedbackService = FeedbackService();
//   double _ratings = 0;
//   final TextEditingController _feedbackController = TextEditingController();
//   String? userId;
//   String? username;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }
//
//   Future<void> getUserData() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       userId = user.uid;
//       UserModel userModel = await getuserData(userId!);
//       setState(() {
//         username = userModel.name;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(userId);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feedback'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//         decoration: BoxDecoration(),
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 'How would you rate our app?',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Card(
//                 color: Colors.white.withOpacity(0.9),
//                 elevation: 4.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: <Widget>[
//                       RatingBar.builder(
//                         initialRating: 3,
//                         minRating: 1,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                         itemBuilder: (context, _) => Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                         ),
//                         onRatingUpdate: (rating) {
//                           setState(() {
//                             _ratings = rating;
//                           });
//                         },
//                       ),
//                       SizedBox(height: 10.0),
//                       TextField(
//                         controller: _feedbackController,
//                         decoration: InputDecoration(
//                           labelText: 'Feedback',
//                           hintText: 'Type your feedback here...',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.multiline,
//                         maxLines: null,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _submitFeedback,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
//                     textStyle: TextStyle(fontSize: 16.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: Text('Submit Feedback', style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Future<UserModel> getuserData(String id) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snap =
//       await FirebaseFirestore.instance.collection('users').doc(id).get();
//       return UserModel.fromJoson(snap.data()! as DocumentSnapshot<Object?>);
//     } catch (e) {
//       print('Error fetching user data: $e');
//       throw e;
//     }
//   }
//
//   Future<void> _submitFeedback() async {
//     String feedbackText = _feedbackController.text.trim();
//     if (feedbackText.isEmpty || _ratings == 0) {
//       Fluttertoast.showToast(
//         msg: "Please provide a rating and feedback.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//       return;
//     }
//
//     try {
//       var feedid = Uuid().v1();
//       User? user = FirebaseAuth.instance.currentUser;
//       String userId = user?.uid ?? 'anonymous';
//       FeedbackModel feedback = FeedbackModel(
//         userId: userId,
//         status: 1,
//         id: feedid,
//         feedback: feedbackText,
//         ratings: _ratings,
//         username: username ,
//         timestamp: DateTime.now(),
//       );
//
//       await _feedbackService.addFeedback(feedback);
//
//       setState(() {
//         _ratings = 0;
//         _feedbackController.clear();
//       });
//
//       Fluttertoast.showToast(
//         msg: "Feedback submitted successfully!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     } catch (e) {
//       print('Error submitting feedback: $e');
//       Fluttertoast.showToast(
//         msg: "Failed to submit feedback.",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/feedback_model.dart';
import 'package:dihub/models/user_model.dart';
import 'package:dihub/services/feedback_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  FeedbackService _feedbackService = FeedbackService();
  double _ratings = 0;
  final TextEditingController _feedbackController = TextEditingController();
  String? userId;
  String? username;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      UserModel userModel = await getuserData(userId!);
      setState(() {
        username = userModel.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(userId);
    print(username);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'How would you rate our app?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                color: Colors.white.withOpacity(0.9),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _ratings = rating;
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        style: TextStyle(color: Colors.blue),
                        controller: _feedbackController,
                        decoration: InputDecoration(
                          labelText: 'Feedback',
                          hintText: 'Type your feedback here...',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    textStyle: TextStyle(fontSize: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Submit Feedback', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserModel> getuserData(String id) async {
    try {
      DocumentSnapshot snap =
      await FirebaseFirestore.instance.collection('user').doc(id).get();
      return UserModel.fromJoson(snap);
    } catch (e) {
      print('Error fetching user data: $e');
      throw e;
    }
  }

  Future<void> _submitFeedback() async {
    String feedbackText = _feedbackController.text.trim();
    if (feedbackText.isEmpty || _ratings == 0) {
      Fluttertoast.showToast(
        msg: "Please provide a rating and feedback.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    try {
      var feedid = Uuid().v1();
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user?.uid ?? 'anonymous';

      // Create a FeedbackModel instance with the provided data
      FeedbackModel feedback = FeedbackModel(
        userId: userId,
        status: 1,
        id: feedid,
        feedback: feedbackText,
        ratings: _ratings,
        username: username,
        timestamp: DateTime.now(),
      );

      // Add the feedback to Firestore
      await _feedbackService.addFeedback(feedback);

      // Clear the fields after successful submission
      setState(() {
        _ratings = 0;
        _feedbackController.clear();
      });

      // Show a success message to the user
      Fluttertoast.showToast(
        msg: "Feedback submitted successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      print('Error submitting feedback: $e');
      // Show an error message to the user if submission fails
      Fluttertoast.showToast(
        msg: "Failed to submit feedback.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
