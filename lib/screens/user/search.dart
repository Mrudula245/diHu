// import 'package:dihub/models/video_model.dart';
// import 'package:dihub/screens/technicalguide/upload_video.dart';
// import 'package:dihub/services/video_service.dart';
// import 'package:flutter/material.dart';
//
// class VideoListPage extends StatefulWidget {
//   @override
//   _VideoListPageState createState() => _VideoListPageState();
// }
//
// class _VideoListPageState extends State<VideoListPage> {
//   int _selectedIndex = 2;
//   final VideoService _videoService = VideoService();
//   List<Map<String, dynamic>> _allVideosWithUsers = [];
//   List<Map<String, dynamic>> _filteredVideosWithUsers = [];
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   _onSearchChanged() {
//     setState(() {
//       _filteredVideosWithUsers = _allVideosWithUsers
//           .where((videoWithUser) =>
//           videoWithUser['videos'].title.toLowerCase().contains(_searchController.text.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.cyan,
//         title:Text( 'Explore',style: TextStyle(color: Colors.white),),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search videos...',
//                 prefixIcon: Icon(Icons.search, color: Color(0xff281537)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xff881736)),
//                   borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<Map<String, dynamic>>>(
//               stream: _videoService.getAllVideosWithUsers(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('No videos available.'));
//                 }
//                 _allVideosWithUsers = snapshot.data!;
//                 _filteredVideosWithUsers = _searchController.text.isEmpty
//                     ? _allVideosWithUsers
//                     : _filteredVideosWithUsers;
//                 return ListView.builder(
//                   itemCount: _filteredVideosWithUsers.length,
//                   itemBuilder: (context, index) {
//                     var videoWithUser = _filteredVideosWithUsers[index];
//                     VideoModel video = videoWithUser['video'];
//                     String username = videoWithUser['username'];
//                     return Card(
//                       color: Color.fromARGB(255, 240, 220, 212),
//                       elevation: 10,
//                       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(10),
//                         leading: Icon(Icons.video_library, size: 50, color: Color(0xff881736)),
//                         title: Text(
//                           video.title,
//                           style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff281537)),
//                         ),
//                         subtitle: Text(
//                           'by $username',
//                           style: TextStyle(color: Color(0xff281537)),
//                         ),
//                         trailing: Icon(Icons.play_arrow, color: Color(0xff881736)),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => VideoPlayerPage(videoUrl: video.url),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // bottomNavigationBar: NavBar(selectedIndex: _selectedIndex, userRole: UserRole.User,),
//     );
//   }
// }