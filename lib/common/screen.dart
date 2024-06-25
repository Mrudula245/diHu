import 'package:dihub/common/login_page.dart';
import 'package:dihub/common/user_register.dart';
import 'package:dihub/widgets/appbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(


         child: Column(

           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              Text("Welcome!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Padding(padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Image(image: AssetImage('assets/img/lapimg.jpg'),),
                ),

              ),
              SizedBox(height: 10,),

              Icon(Icons.facebook,
              size: 35,
              color: Colors.blue,),
            //   google image
              Center(
                child: SizedBox(
                  height: 45,
                ),

              ),
              AppButton(title:"Sign In",onPressed:(){
               Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginPage() ));
                   },),
              SizedBox(height: 15,),
              AppButton(title:"Sign Up",onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>  Register () ));
              } ,)



            ],


         ),



      ),
    );
  }
}
