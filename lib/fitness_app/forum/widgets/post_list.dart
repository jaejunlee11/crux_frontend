import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/post_tab.dart';
import 'package:flutter/material.dart';
import '../../models/forum_post_list_data.dart';
import "post_list_items.dart";

int minimumLikes = 10;

class ForumPostList extends StatelessWidget{
  final List<ForumPost> forumpostlist;
  ForumPostList({required this.forumpostlist});

  @override
  Widget build(BuildContext context){
    return ListView(
      children: getChilderenPosts(),
      );
  }


List<Widget> getChilderenPosts(){
  return forumpostlist.map((posts)=>ForumPostListItem(forumpost:posts)).toList();
}

List<Widget> getFilteredChildrenPosts() {
    final filteredPosts =
        forumpostlist.where((post) => post.like >= minimumLikes).toList();

    return filteredPosts.map((post) => ForumPostListItem(forumpost: post)).toList();
  }

}
