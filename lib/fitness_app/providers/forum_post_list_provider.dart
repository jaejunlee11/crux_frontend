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
    final response = await http.get(Uri.parse("http://10.0.2.2:8000/forumpost/"));  //localhost 임시설정(10.0.2.2 for android?/127.0.0.1 for pc?)
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      _posts = data.map<ForumPost>((json)=> ForumPost.fromJson(json)).toList();
      notifyListeners();
    }  

  }
}


//안드로이드 환경에서만 작동을 확인? 
//pc 환경에서의 error 점검 필요
//https://youngwonhan-family.tistory.com/entry/FlutterDart-%EC%98%A4%EB%A5%98-%ED%95%B4%EA%B2%B0-Error-XMLHttpRequest-error
