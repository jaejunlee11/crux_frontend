
import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/post_detail_tab.dart';
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_post_list_data.dart';
import '../widgets/post_list.dart';

int docID = 0;
int getID = 0;

class ForumPostTab extends StatelessWidget {
  final Function(int) onTapCallback;

  ForumPostTab({required this.onTapCallback});

int getdocID() {

  getID = docID;
  return getID;
}


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Consumer<ForumPostProvider>(

        builder: (context,value,child)=> ForumPostList(
          forumpostlist: value.allPosts
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

