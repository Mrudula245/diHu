import 'package:dihub/common/user_register.dart';

import 'package:dihub/screens/technicalguide/guide_register.dart';
import 'package:flutter/material.dart';

class RegisterTab extends StatelessWidget {
  const RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(

            bottom: const TabBar(
              isScrollable: true,
              padding: EdgeInsets.all(20),
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.blue,
              labelStyle: TextStyle(color: Colors.blueAccent),
              tabs: [
                Text("user Registration"),
                Text("Guide Registration"),




              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              Register(),

              GuideRegister(),



            ],
          ),
        ),
      ),
    );
  }
}