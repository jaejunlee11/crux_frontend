import "package:flutter/material.dart";
import "../../models/forum_post_list_data.dart";
import "../tabs/post_detail_tab.dart";


class ForumPostListItem extends StatelessWidget {
  final ForumPost forumpost;
  ForumPostListItem({required this.forumpost});

  @override
  Widget build(BuildContext context) {
    return InkWell(  
      onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumPostDetail(forumpost.documentnum)),
                );
            },
    
    
    child: ListTile(
      title:Text(forumpost.title),
      subtitle:Text(forumpost.content, maxLines:2),
    )
    );
  }
}