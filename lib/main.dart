import 'package:dihub/firebase_options.dart';
import 'package:dihub/screens/admin/dashboard.dart';
import 'package:dihub/screens/admin/guide_info.dart';
import 'package:dihub/screens/technicalguide/add-product.dart';
import 'package:dihub/screens/technicalguide/guide_dashboard.dart';
import 'package:dihub/screens/technicalguide/add_category.dart';

import 'package:dihub/screens/technicalguide/guide_home.dart';

import 'package:dihub/screens/technicalguide/guide_register.dart';
import 'package:dihub/screens/technicalguide/upload_video.dart';
import 'package:dihub/screens/technicalguide/user_appointmentscreen.dart';
import 'package:dihub/screens/user/Shedule_date.dart';
import 'package:dihub/screens/user/discription_page.dart';
import 'package:dihub/screens/user/guide_details.dart';
import 'package:dihub/screens/user/feedback_page.dart';
import 'package:dihub/screens/user/guide_list.dart';
import 'package:dihub/screens/user/my_cart.dart';
import 'package:dihub/screens/user/personal_info.dart';
import 'package:dihub/screens/user/privacy_policy.dart';
import 'package:dihub/screens/user/profile.dart';
import 'package:dihub/screens/user/recommendation.dart';
import 'package:dihub/screens/user/reset_password.dart';
import 'package:dihub/screens/user/search.dart';
import 'package:dihub/screens/user/user_explore.dart';
import 'package:dihub/common/login_page.dart';
import 'package:dihub/common/user_register.dart';
import 'package:dihub/common/screen.dart';
import 'package:dihub/common/splash_page.dart';
import 'package:dihub/screens/user/user_home.dart';
import 'package:dihub/screens/user/watch_videos.dart';
import 'package:dihub/widgets/bottom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dihub/models/cart_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CartModel('user123'), // Replace 'user123' with actual user ID
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          'login': (context) => LoginPage(),
          'register': (context) => Register(),
          'userhome': (context) => BottomNavigationPage(),
          'adminhome': (context) => AdminPage(),
          'guidehome': (context) => GuideHome(),
          'producthome': (context) => AddProduct(),
          'registerguide': (context) => GuideRegister(),
          // 'personalinfo': (context) => PersonalInfo(),
          'feedback': (context) => FeedbackPage(),
          'explore': (context) => ExplorePage(),

          'guidelist': (context) => GuideList(),
          'bottomnav': (context) => BottomNavigationPage(),
          'dashboard': (context) => GuideDashboard(),
          'sheduleappointment': (context) => AppointmentFormScreen(userId: ''),
          'videos': (context) => VideoViewPage(),
          'add-category': (context) => AddCategory(),
          // 'guideexplore': (context) => GuideCategory(),
          // 'phonediscription': (context) => PhoneDiscription(),
          // 'history': (context) => VideoViewPage(),
          // 'laptop': (context) => LaptopPage(),
          // 'discription': (context) => DiscriptionPage(),
          // 'phone': (context) => PhoneList(),
          // 'camera': (context) => CameraList(),
          // 'airpod': (context) => AirpodsList(),
          //  'search': (context) => Search(),
          // 'profile':(context)=>ProfilePage(),
          'guidedetail': (context) => GuideDetail(),
          'appointment': (context) => ViewAppointmentsScreen(userId: ''),
          'privacy':(context)=>PrivacyPolicyScreen(),
          'recommendation':(context)=> ViewRecommendations(),
          'privacypolicy':(context)=>PrivacyPolicyScreen(),
          'resetpassword':(context)=>ResetPassword(),
          'cart':(context)=> CartPage(),
          'personalinfo':(context)=>PersonalInfo()
          // 'guideprofile':(context)=>GuideAccount()
         // 'videos':(context)=>UploadVideo()
         },
        //   home:GuideInfo(),
      ),
    );
  }
}
