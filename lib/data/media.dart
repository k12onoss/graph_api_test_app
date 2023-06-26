class Media {
  String id;
  String mediaType;
  int commentsCount;
  int likeCount;
  String mediaUrl;
  List comments;

  Media({
    required this.id,
    required this.mediaType,
    required this.commentsCount,
    required this.likeCount,
    required this.mediaUrl,
    required this.comments,
  });

  factory Media.fromJson(Map json) {
    return Media(
      id: json['id'],
      mediaType: json['media_type'],
      commentsCount: json['comments_count'],
      likeCount: json['like_count'],
      mediaUrl: json['media_url'],
      comments: json['comments']['data'],
    );
  }
}
