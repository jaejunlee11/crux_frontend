import 'dart:collection';
import 'dart:convert';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_post_list_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumPostProvider extends ChangeNotifier {
ForumPostProvider(){
  this.fetchPosts();
}


  List<ForumPost> _posts= [];
  UnmodifiableListView<ForumPost> get allPosts =>
    UnmodifiableListView(_posts);
  fetchPosts() async {
    final response = await http.get("http://3.39.160.193:8000/forumpost/" as Uri);  
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      _posts = data.map<ForumPost>((json)=> ForumPost.fromJson(json)).toList();
      notifyListeners();
    }  

  }
}
