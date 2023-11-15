import 'dart:collection';
import 'dart:convert';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_post_list_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumPostProvider extends ChangeNotifier {
  ForumPostProvider() {
    fetchPosts();
  }

  List<ForumPost> _posts = [];
  UnmodifiableListView<ForumPost> get allPosts => UnmodifiableListView(_posts);

  fetchPosts() async {
    final response = await http.get(Uri.parse(
        "http://10.0.2.2:8000/forumpost/")); //localhost 임시설정(10.0.2.2 for android?/127.0.0.1 for pc?)
    // final response =
    //     await http.get(Uri.parse("http://0.0.0.0:8000/forumpost/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      _posts = data.map<ForumPost>((json) => ForumPost.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> addPost(ForumPost newPost) async {
    final postJson = newPost.toJson();

    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/post-forumpost/"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postJson),
    );

    if (response.statusCode == 201) {
      // Successfully added the new post to the database.
    } else {
      // Handle errors, e.g., server error or validation error
      throw Exception(
          'Failed to add post. Status code: ${response.statusCode}');
    }

}
  Future<void> updateLikes(int postId, int newLike) async {
    final postIndex = _posts.indexWhere((post) => post.documentnum == postId);

    if (postIndex != -1) {
      final updatedPost = _posts[postIndex].copyWith(like: newLike);
      _posts[postIndex] = updatedPost;
      notifyListeners();

      // Update the likes in the database
      final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/put-forumpost/$postId"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedPost.toJson()),
      );

      if (response.statusCode != 200) {
        // Handle errors when updating likes in the database
        throw Exception('Failed to update likes. Status code: ${response.statusCode}');
      }
    }
  }

Future<void> updateDislikes(int postId, int newDislike) async {
   final postIndex = _posts.indexWhere((post) => post.documentnum == postId);

    if (postIndex != -1) {
      final updatedPost = _posts[postIndex].copyWith(dislike: newDislike);
      _posts[postIndex] = updatedPost;
      notifyListeners();

      // Update the likes in the database
      final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/put-forumpost/$postId"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedPost.toJson()),
      );

      if (response.statusCode != 200) {
        // Handle errors when updating likes in the database
        throw Exception('Failed to update dislikes. Status code: ${response.statusCode}');
      }
    }
  }

    Future<void> likePost(int postId) async {
    final specificPost = _posts.firstWhere(
      (post) => post.documentnum == postId,
      orElse: () => ForumPost(documentnum: 0, title: "Post not found", like: 0, dislike: 0, content: " ",username: " ",postdate: " "),
    );

    // Update the likes for the specific post
    await updateLikes(postId, specificPost.like + 1);
  }

    Future<void> dislikePost(int postId) async {
    final specificPost = _posts.firstWhere(
      (post) => post.documentnum == postId,
      orElse: () => ForumPost(documentnum: 0, title: "Post not found", like: 0, dislike: 0, content: " ",username: " ",postdate: " "),
    );

    // Update the dislikes for the specific post
    await updateDislikes(postId, specificPost.dislike + 1);
  }



}






  


//안드로이드 환경에서만 작동을 확인? 
//pc 환경에서의 error 점검 필요
//https://youngwonhan-family.tistory.com/entry/FlutterDart-%EC%98%A4%EB%A5%98-%ED%95%B4%EA%B2%B0-Error-XMLHttpRequest-error
