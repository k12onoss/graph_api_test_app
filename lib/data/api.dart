import 'dart:convert';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:graph_api_test_app/data/facebook_page.dart';
import 'package:graph_api_test_app/data/instagram_profile.dart';
import 'package:graph_api_test_app/data/media.dart';
import 'package:graph_api_test_app/data/profile.dart';
import 'package:http/http.dart' as http;

class FacebookAPI {
  final fb = FacebookLogin();
  final baseUrl = 'graph.facebook.com';
  final client = http.Client();

  Future<bool> get isLoggedIn async => await fb.isLoggedIn;

  Future<void> login() async {
    final res = await fb.logIn(permissions: [
      FacebookPermission.instagramBasic,
      FacebookPermission.pagesShowList,
      FacebookPermission.pagesReadEngagement,
      FacebookPermission.readInsights,
      FacebookPermission.pagesManagePosts,
    ]);

    print(res.toMap());
  }

  Future<Profile> getProfile() async {
    final response = await Future.wait([
      fb.getUserProfile(),
      fb.getProfileImageUrl(width: 100),
      fb.getUserEmail(),
    ]);

    return Profile(
      name: (response[0] as FacebookUserProfile).name!,
      imageUrl: response[1]?.toString(),
      email: response[2]?.toString(),
    );
  }

  Future<PageAPIResponse> getUsersPages() async {
    final accessToken = (await fb.accessToken)?.token;
    final url = Uri.https(
      baseUrl,
      '/v17.0/me/accounts',
      {'access_token': accessToken},
    );
    final response = await client.get(url);
    final json = jsonDecode(response.body);

    print(json);
    return PageAPIResponse.fromJson(json);
  }

  Future<String> getInstagramAccountID(String pageID) async {
    final accessToken = (await fb.accessToken)?.token;
    final uri = Uri.https(
      baseUrl,
      '/v17.0/$pageID',
      {
        'fields': 'instagram_business_account',
        'access_token': accessToken,
      },
    );
    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    print(json);
    return json['instagram_business_account']['id'];
  }

  Future<InstagramProfile> getInstagramUser(String id) async {
    final accessToken = (await fb.accessToken)?.token;
    final uri = Uri.https(
      baseUrl,
      '/v17.0/$id',
      {
        'access_token': accessToken,
        'fields':
            'biography, id, followers_count, follows_count, name, username, media, profile_picture_url, media_count',
      },
    );
    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    print(json);
    return InstagramProfile.fromJson(json);
  }

  Future<Media> getMedia(String mediaID) async {
    final accessToken = (await fb.accessToken)?.token;
    final uri = Uri.https(
      baseUrl,
      '/v17.0/$mediaID',
      {
        'access_token': accessToken,
        'fields':
        'id, comments_count, like_count, media_type, media_url, comments{username, text, timestamp}',
      },
    );
    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    print(json);
    return Media.fromJson(json);
  }

  Future<void> logout() async {
    await fb.logOut();
  }
}
