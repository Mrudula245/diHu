// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class TermsAndPolicyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Terms and Policy'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Terms of Service',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Introduction: Your introduction text goes here...',
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Acceptance of Terms: By using this app, you agree to abide by the terms outlined...',
//             ),
//             // Add more sections for other terms of service
//
//             SizedBox(height: 20),
//
//             Text(
//               'Privacy Policy',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Information Collection: We collect information such as...',
//             ),
//             // Add more sections for other privacy policy details
//
//             SizedBox(height: 20),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     launch('https://yourwebsite.com/terms_of_service');
//                   },
//                   child: Text(
//                     'Terms of Service',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 TextButton(
//                   onPressed: () {
//                     launch('https://yourwebsite.com/privacy_policy');
//                   },
//                   child: Text(
//                     'Privacy Policy',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
