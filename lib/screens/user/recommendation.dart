import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dihub/models/request_model.dart';
import 'package:dihub/models/product_model.dart';
import 'package:dihub/services/recomentaion_service.dart';

class ViewRecommendations extends StatefulWidget {
  @override
  _ViewRecommendationsState createState() => _ViewRecommendationsState();
}

class _ViewRecommendationsState extends State<ViewRecommendations> {
  final RecommendationService _recommendationService = RecommendationService();
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      setState(() {});
    }
  }

  Future<ProductModel> getProductData(String id) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('products').doc(id).get();
    return ProductModel.fromSnapshot(snap);
  }

  void _showFeedbackDialog(String recommendationId) {
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Give Feedback'),
          content: TextField(
            controller: feedbackController,
            decoration: InputDecoration(
              hintText: 'Enter your feedback',
            ),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                String feedback = feedbackController.text.trim();
                if (feedback.isNotEmpty) {
                  await _saveFeedback(recommendationId, feedback);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feedback submitted successfully!')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveFeedback(String recommendationId, String feedbackContent) async {
    final feedback = {
      'userId': userId,
      'content': feedbackContent,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('recommendations')
          .doc(recommendationId)
          .collection('feedback')
          .add(feedback);
    } catch (e) {
      print('Error saving feedback: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit feedback.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('View Recommendations',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.cyan,
      ),
      body: userId == null
          ? Center(
        child: Text('User not logged in.'),
      )
          : FutureBuilder<List<RequestModel>>(
        future: _recommendationService.getRecommendations(userId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No recommendations found.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                RequestModel recommendation = snapshot.data![index];
                return FutureBuilder<ProductModel>(
                  future: getProductData(recommendation.productId!),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (productSnapshot.hasError) {
                      return Center(
                        child: Text('Error: ${productSnapshot.error}'),
                      );
                    } else if (productSnapshot.hasData) {
                      ProductModel product = productSnapshot.data!;
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
                          title: Text('Recommendation ${index + 1}',style: TextStyle(color: Colors.white),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(recommendation.reply ?? 'No reply available'),
                              Text('Product: ${product.title}',style: TextStyle(color: Colors.white),),
                              // Text('product:${product.desc}',style: TextStyle(color: Colors.white),),// Assuming 'title' is a property of ProductModel
                              SizedBox(height: 8),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     _showFeedbackDialog(recommendation.id!);
                              //   },
                              //   child: Text('Give Feedback'),
                              // ),
                            ],
                          ),
                        ),
                    ) );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
