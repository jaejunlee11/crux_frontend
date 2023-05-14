import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_post_list_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_comments_list_data.dart';
import 'forum_new_post_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// 민재 : 게시판 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class ForumApp extends StatefulWidget {
  @override
  _ForumAppState createState() => _ForumAppState();
}

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자유 게시판'),
      ),
      body: ListView.builder(
        itemCount: ForumPostListData.forumPosts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(ForumPostListData.forumPosts[index].title),
            subtitle: Text(ForumPostListData.forumPosts[index].content),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PostScreen(post: ForumPostListData.forumPosts[index])),
              );
            },
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 50.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPostScreen()),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class PostScreen extends StatelessWidget {
  final ForumPost post;

  PostScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Column(
        children: [
          Text(post.content),
          Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: post.comments.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(post.comments[index].username),
                subtitle: Text(post.comments[index].content),
              );
            },
          ),
        ],
      ),
    );
  }
}
