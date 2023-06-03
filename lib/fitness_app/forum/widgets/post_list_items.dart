import "package:flutter/material.dart";
import "../../models/forum_post_list_data.dart";


class ForumPostListItem extends StatelessWidget {
  final ForumPost forumpost;
  ForumPostListItem({required this.forumpost});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(forumpost.title),
      subtitle:Text(forumpost.username),
    );
  }
}