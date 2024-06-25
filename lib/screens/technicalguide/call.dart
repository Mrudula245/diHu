import 'package:flutter/material.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement call functionality here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Call initiated!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: Text('Initiate Call'),
        ),
      ),
    );
  }
}
