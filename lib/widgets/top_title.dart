import 'package:flutter/material.dart';
class TopTitles extends StatelessWidget {
  final String title;
  final String subtitle;
  const TopTitles({super.key,required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: kToolbarHeight + 12,



        ),
        Icon(Icons.arrow_back),
        Text(
              title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(title,
        style: TextStyle(
          fontSize: 18.0,
        ),)
      ],
    );
  }
}
