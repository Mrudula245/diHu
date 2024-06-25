import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Privacy Policy',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to our gadget information guidance app! At [Your App Name], we are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your information when you use our app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'When you use our app, we may collect various types of information, including:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '- Device Information: We may collect information about the device you use to access our app, such as the device model, operating system version, and unique device identifiers.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Usage Data: We may collect information about how you interact with our app, including the features you use, the time spent on each screen, and other usage statistics.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Location Information: With your consent, we may collect information about your approximate location to provide location-based services.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We use the information we collect for various purposes, including:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '- Personalization: We use your information to personalize your experience and provide you with relevant content and recommendations.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Analytics: We analyze usage data to understand how our app is used, identify trends, and improve our services.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Communication: We may use your contact information to communicate with you about updates, promotions, and other relevant information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Your Choices and Rights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You have the right to:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '- Access, update, or delete your personal information.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Opt-out of certain data collection and processing activities.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Withdraw your consent for the processing of your information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or concerns about our Privacy Policy, please contact us:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '- Email: support@example.com',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Phone: +1234567890',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
