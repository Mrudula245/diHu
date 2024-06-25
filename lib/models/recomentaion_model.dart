class RecommendationModel {
  final String productId;
  final String guideId;
  final String userId;
  final String username;
  final int status; // 0: Pending, 1: Approved, 2: Rejected
   String ?recommendation;

  RecommendationModel({
    required this.productId,
    required this.guideId,
    required this.userId,
    required this.username,
    required this.status,
    this.recommendation,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      productId: json['productId'],
      guideId: json['guideId'],
      userId: json['userId'],
      username: json['username'],
      status: json['status'],
      recommendation: json['recommendation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'guideId': guideId,
      'userId': userId,
      'username': username,
      'status': status,
      'recommendation': recommendation,
    };
  }
}
