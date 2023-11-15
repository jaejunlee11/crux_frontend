import "package:flutter/material.dart";
import "../../models/forum_crew_post_list_data.dart";
import "../../models/forum_post_list_data.dart";
import "../tabs/crew_detail.tab.dart";



class ForumCrewPostListItem extends StatelessWidget {
  final ForumCrewPost forumcrewpost;
  ForumCrewPostListItem({required this.forumcrewpost});

  @override
  Widget build(BuildContext context) {
    Icon leadingIcon;
    if (forumcrewpost.like <= forumcrewpost.dislike) {
      leadingIcon = Icon(Icons.person);
    } else {
      leadingIcon = Icon(Icons.person_outline);
    }



 return InkWell(  
      onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumCrewPostDetail(forumcrewpost.documentnum)),
                );
            },
    
    
  child: ListTile(
      leading: leadingIcon,
      title: Text(forumcrewpost.title),
      subtitle: Text('${forumcrewpost.region} - total members: ${forumcrewpost.dislike} - now: ${forumcrewpost.like}' ),
    )
 );
  }
}