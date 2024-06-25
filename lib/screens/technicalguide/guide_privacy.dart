import 'package:flutter/material.dart';


class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Effective Date: [Insert Date]',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Welcome to [Your App Name] ("we," "our," or "us"). We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application ("App"). Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may collect and store the following types of information when you use our App:\n\n'
                  '- Personal Information: Information that can be used to identify you, such as your name, email address, and phone number.\n'
                  '- Device Information: Information about the device you use to access the App, including the hardware model, operating system, and device identifiers.\n'
                  '- Usage Data: Information about how you use our App, such as the features you use and the time spent on the App.\n'
                  '- Location Information: We may collect information about your location if you permit us to do so through your device settings.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We use the information we collect for various purposes, including:\n\n'
                  '- To provide and maintain our App.\n'
                  '- To improve, personalize, and expand our App.\n'
                  '- To understand and analyze how you use our App.\n'
                  '- To develop new products, services, features, and functionality.\n'
                  '- To communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the App, and for marketing and promotional purposes.\n'
                  '- To process your transactions and manage your orders.\n'
                  '- To find and prevent fraud.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Sharing Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We do not sell, trade, or otherwise transfer your personal information to outside parties except as described in this Privacy Policy. We may share your information in the following situations:\n\n'
                  '- With Service Providers: We may share your information with third-party service providers to perform services on our behalf, such as data analysis, payment processing, and customer service.\n'
                  '- For Legal Reasons: We may disclose your information if required to do so by law or in response to valid requests by public authorities (e.g., a court or a government agency).\n'
                  '- Business Transfers: If we are involved in a merger, acquisition, or asset sale, your information may be transferred as part of that transaction.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Security of Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable, and no method of data transmission can be guaranteed against any interception or other type of misuse.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Your Data Protection Rights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Depending on your location, you may have the following rights regarding your personal information:\n\n'
                  '- Right to Access: You have the right to request copies of your personal information.\n'
                  '- Right to Rectification: You have the right to request that we correct any information you believe is inaccurate or incomplete.\n'
                  '- Right to Erasure: You have the right to request that we erase your personal information under certain conditions.\n'
                  '- Right to Restrict Processing: You have the right to request that we restrict the processing of your personal information under certain conditions.\n'
                  '- Right to Object to Processing: You have the right to object to our processing of your personal information under certain conditions.\n'
                  '- Right to Data Portability: You have the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain conditions.\n\n'
                  'If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us at our contact information below.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Children\'s Privacy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Our App does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. If we become aware that we have collected personal information from a child under age 13 without verification of parental consent, we take steps to remove that information from our servers.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '8. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page. You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              '9. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you have any questions about this Privacy Policy, please contact us:\n\n'
                  '- By email: [Your Email Address]\n'
                  '- By visiting this page on our website: [Your Website URL]\n'
                  '- By phone number: [Your Phone Number]\n'
                  '- By mail: [Your Physical Address]',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
