import 'dart:collection';
import 'dart:convert';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_crew_post_list_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumCrewPostProvider extends ChangeNotifier {
ForumCrewPostProvider(){
  fetchPosts();
}

  List<ForumCrewPost> _posts= [];
  UnmodifiableListView<ForumCrewPost> get allPosts => UnmodifiableListView(_posts);

  Future<ForumCrewPost> fetchPostById(int postId) async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8000/forumcrewpost/$postId"));
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return ForumCrewPost.fromJson(data);
    } else {
      throw Exception('Failed to load post');
    }
  }

  fetchPosts() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8000/forumcrewpost/"));  //localhost 임시설정(10.0.2.2 for android?/127.0.0.1 for pc?)
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      _posts = data.map<ForumCrewPost>((json)=> ForumCrewPost.fromJson(json)).toList();
      notifyListeners();
    }  
    else{
      throw Exception("Failed to load post");
    }

  }

    Future<void> addPost(ForumCrewPost newPost) async {
    final postJson = newPost.toJson();

    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/post-forumcrewpost/"), 
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postJson),
    );

    if (response.statusCode == 201) {
      // Successfully added the new post to the database.
    } else {
      // Handle errors, e.g., server error or validation error
      throw Exception('Failed to add post. Status code: ${response.statusCode}');
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

    Future<void> likePost(int postId) async {
    final specificPost = _posts.firstWhere(
      (post) => post.documentnum == postId,
      orElse: () => ForumCrewPost(documentnum: 0, title: "Post not found", like: 0, dislike: 0, content: " ",username: " ",postdate: " ",region: " "),
    );

    // Update the likes for the specific post
    await updateLikes(postId, specificPost.like + 1);
  }







}