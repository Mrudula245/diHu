import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dihub/models/video_model.dart';


class VideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveVideoData(String uid,VideoModel video) async {
    await _firestore.collection('users').doc(uid).collection('videos').doc(video.id).set(video.toMap());
  }

  Stream<List<VideoModel>> getVideos(String uid) {
    return _firestore.collection('users').doc(uid).collection('videos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    });
  }

  Stream<List<VideoModel>> getAllVideos() {
    return _firestore.collectionGroup('videos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> getAllVideosWithUsers() async* {
    var userSnapshot = await _firestore.collection('users').get();
    List<Map<String, dynamic>> videosWithUsers = [];

    for (var userDoc in userSnapshot.docs) {
      var userData = userDoc.data() as Map<String, dynamic>;
      var videoSnapshot = await userDoc.reference.collection('videos').get();

      for (var videoDoc in videoSnapshot.docs) {
        var videoData = videoDoc.data() as Map<String, dynamic>;

        videosWithUsers.add({
          'video': VideoModel.fromMap(videoData),
          'username': userData['username'],
        });
      }
    }

    yield videosWithUsers;
  }

  Future<void> deleteVideo(VideoModel video, String uid) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('videos')
          .doc(video.id)
          .delete();
    } catch (e) {
      throw Exception('Error deleting video: $e');
    }
  }
}

