import "package:flutter/material.dart";
import "../../models/forum_post_list_data.dart";


class PostListItem extends StatelessWidget {
  final ForumPost post;
  PostListItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:Text(post.title),
      subtitle:Text(post.username),
    );
  }
}