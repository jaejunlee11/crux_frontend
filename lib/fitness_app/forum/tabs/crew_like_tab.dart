import 'package:best_flutter_ui_templates/fitness_app/forum/forum_post_detail.dart';
import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/post_detail_tab.dart';
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_crew_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_crew_post_list_data.dart';
import '../widgets/crew_post_list.dart';

int docID = 0;
int getID = 0;
int minlike = 7;

class ForumCrewLikeTab extends StatelessWidget {
  final Function(int) onTapCallback;

  ForumCrewLikeTab({required this.onTapCallback});

int getdocID() {

  getID = docID;
  return getID;
}


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Consumer<ForumCrewPostProvider>(

        builder: (context,value,child)=> ForumCrewPostList(
          forumcrewpostlist: value.allPosts.where((post)=>post.like <= post.dislike).toList()
        ),
      ),
      /*
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(45),
        ),
        border: Border.all(
          color: Colors.black,
          width: 3,
            ),
        )
        */
    );
  }
}