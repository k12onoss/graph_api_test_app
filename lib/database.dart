import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('instagram');
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> updateFollowersAndFollowing(
      {int? followers, int? following}) async {
    final data = following == null
        ? {'followers': followers}
        : followers == null
            ? {'following': following}
            : {
                'followers': followers,
                'following': following,
              };

    _collection.doc('1').set(data);
  }

  void updateCommentsAndLikes(String id, {int? likes, List? comments}) {
    final data = comments == null
        ? {'likes': likes}
        : likes == null
            ? {'comments': comments}
            : {
                'likes': likes,
                'comments': comments,
              };

    _postCollection.doc(id).set(data);
  }
}
