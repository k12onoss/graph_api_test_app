class InstagramProfile {
  String id;
  String name;
  String username;
  String profilePictureUrl;
  String bio;
  int followersCount;
  int followsCount;
  int mediaCount;
  List<String> mediaIDs;

  InstagramProfile({
    required this.id,
    required this.name,
    required this.username,
    required this.profilePictureUrl,
    required this.bio,
    required this.followersCount,
    required this.followsCount,
    required this.mediaCount,
    required this.mediaIDs,
  });

  factory InstagramProfile.fromJson(Map<String, dynamic> json) {
    final mediaIDs = List.generate(
      json['media']['data'].length,
      (index) => json['media']['data'][index]['id'].toString(),
    );

    return InstagramProfile(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      profilePictureUrl: json['profile_picture_url'],
      bio: json['biography'],
      followersCount: json['followers_count'],
      followsCount: json['follows_count'],
      mediaCount: json['media_count'],
      mediaIDs: mediaIDs,
    );
  }
}
