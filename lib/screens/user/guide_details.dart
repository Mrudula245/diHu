import 'package:flutter/material.dart';

class GuideDetail extends StatefulWidget {
  const GuideDetail({Key? key}) : super(key: key);

  @override
  State<GuideDetail> createState() => _GuideDetailState();
}

class _GuideDetailState extends State<GuideDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Detail'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Salesman Details Section
          Text(
            'Guide: John Smith',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            'Experience: 10 years',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Expertise: Mobile Devices, Laptops, and Accessories',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 16.0),
          // Customer Reviews Section
          Text(
            'Customer Reviews:',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          // Example Customer Review 1
          ListTile(
            title: Text(
              'Excellent service!',
              style: TextStyle(fontSize: 18.0),
            ),
            subtitle: Text(
              'John was very knowledgeable and helped me find the perfect smartphone. I highly recommend him to anyone looking for expert advice.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Divider(), // Divider for visual separation
          // Example Customer Review 2
          ListTile(
            title: Text(
              'Friendly and helpful',
              style: TextStyle(fontSize: 18.0),
            ),
            subtitle: Text(
              'I had a great experience with John. He patiently answered all my questions and provided valuable insights into different laptop models.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // Add more customer reviews as needed

          SizedBox(height: 16.0), // Add some spacing

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'sheduleappointment');
                },
                child: Text('Appointment'),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
