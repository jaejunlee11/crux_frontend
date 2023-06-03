import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_post_list_data.dart';
import 'forum_new_post_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forum_post_home.dart';

// 민재 : 게시판 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
// Post/reply의 분리 구현중
// class(model)의 분리 필요
/*
class ForumApp extends StatefulWidget {
  const ForumApp({super.key});

  @override
  _ForumAppState createState() => _ForumAppState();
}
*/
/*
class _ForumAppState extends State<ForumApp> {


List<Comment> comments = [];
List<ForumPost> posts = [];
bool isLoading = false;

_fetchComments() async{
  setState(() {
    isLoading =true;
  });

  final response = await http.get('http://3.39.160.193:8000/comments/')
}
}
*/

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForumPostProvider(),
      child: MaterialApp(
        title: '자유 게시판(전체보기)',
        home: ForumHomeScreen(),
      ),
    );
  }
}







/*
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class PostScreen extends StatelessWidget {
  final ForumPost post;

  const PostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
*/