import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/post_tab.dart';
import 'package:flutter/material.dart';
import '../../models/forum_post_list_data.dart';
import "post_list_items.dart";

class PostList extends StatelessWidget{
  final List<ForumPost> postlist;
  PostList({required this.postlist});

  @override
  Widget build(BuildContext context){
    return ListView(
      children: getChilderenPosts(),
      );
  }


List<Widget> getChilderenPosts(){
  return postlist.map((ForumPost)=>PostListItem(post:ForumPost)).toList();
}

}
