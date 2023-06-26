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

// "media": {
// "data": [
// {
// "id": "18322676257013606"
// },
// {
// "id": "17897733397403758"
// },
// {
// "id": "17844751111460338"
// },
// {
// "id": "17864720200359951"
// }
// ],
// "paging": {
// "cursors": {
// "before": "QVFIUmhIN1VSY3lDOXhvS1VETjVrMFdCRGRCN0RFRXJNQ3A2a2JRMUlfVGFPcC10QkNVbFJYaWtPeUR1TGJrcEpjTDNjYTF4VjhSRDdYa1VGeVpKcXFlVXVR",
// "after": "QVFIUm5mSmNnRnZAaZAm9NSEp4d3ZAGZA0JIU3ZAzbEdOZAnliMjRXQmtZATnlJTEtEUy0tSEtPcjllb1ExaEpFRjBIaTVua3BfbWN1XzRONGVqWFdoV1hrVXRtem9B"
// }
// }
// }
