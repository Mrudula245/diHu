import 'package:dihub/models/recomentaion_model.dart';
import 'package:dihub/models/request_model.dart';
import 'package:flutter/material.dart';
import '../../services/recomentaion_service.dart';

class Recommendation extends StatefulWidget {
  final RequestModel? req;
  const Recommendation({Key? key, this.req}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  TextEditingController _recommendationController = TextEditingController();
  RecommendationService _recommendationService = RecommendationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Recommendations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // Set icons to white
      ),
      body: Container(
        decoration: BoxDecoration(
          // Uncomment if you want to use gradient background
          // gradient: LinearGradient(
          //   colors: [
          //     Colors.blue.shade900,
          //     Colors.blue.shade600,
          //     Colors.blue.shade300,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100), // Space for the AppBar
              Text(
                'Give Your Recommendations:',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _recommendationController,
                maxLines: 5,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type your recommendations here...',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.blue.shade800,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String recommendation = _recommendationController.text.trim();
                    if (recommendation.isNotEmpty) {
                      await _recommendationService
                          .addRecommendation(widget.req!, recommendation);
                      _recommendationController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Recommendation submitted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter your recommendations!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

