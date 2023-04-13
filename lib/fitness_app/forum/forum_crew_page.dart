import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_crew_post_list_data.dart';
import 'forum_new_post_page.dart';

class CrewForumApp extends StatefulWidget {
  @override
  _CrewForumAppState createState() => _CrewForumAppState();
}

class _CrewForumAppState extends State<CrewForumApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('크루 모집 게시판'),
      ),
      body: ListView.builder(
        itemCount: CrewForumPostListData.forumPosts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(CrewForumPostListData.forumPosts[index].title),
            subtitle: Text(
                "${CrewForumPostListData.forumPosts[index].content} | ${CrewForumPostListData.forumPosts[index].region}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrewPostScreen(
                        post: CrewForumPostListData.forumPosts[index])),
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

class CrewPostScreen extends StatelessWidget {
  final CrewForumPost post;

  CrewPostScreen({required this.post});

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
