import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/post_tab.dart';
import 'package:flutter/material.dart';
import '../../models/forum_crew_post_list_data.dart';
import 'crew_post_list_items.dart';


int minimumLikes = 7;

class ForumCrewPostList extends StatelessWidget{
  final List<ForumCrewPost> forumcrewpostlist;
  ForumCrewPostList({required this.forumcrewpostlist});

  @override
  Widget build(BuildContext context){
    return ListView(
      children: getChilderenPosts(),
      );
  }


List<Widget> getChilderenPosts(){
  return forumcrewpostlist.map((posts)=>ForumCrewPostListItem(forumcrewpost:posts)).toList();
}

List<Widget> getFilteredChildrenPosts() {
    final filteredPosts =
        forumcrewpostlist.where((post) => post.like >= minimumLikes).toList();

    return filteredPosts.map((post) => ForumCrewPostListItem(forumcrewpost: post)).toList();
  }



}
