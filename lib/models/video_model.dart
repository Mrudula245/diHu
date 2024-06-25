// class VideoModel {
//   String id;
//   String title;
//   String url;

//   VideoModel({required this.id, required this.title, required this.url});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'url': url,
//     };
//   }

//   factory VideoModel.fromMap(Map<String, dynamic> map) {
//     return VideoModel(
//       id: map['id'],
//       title: map['title'],
//       url: map['url'],
//     );
//   }
// }


class VideoModel {
  String id;
  // User ID of the uploader
  String title;
  String url;

  VideoModel({
    required this.id,
    required this.title,
    required this.url,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      title: map['title'],
      url: map['url'],
    );
  }
}

