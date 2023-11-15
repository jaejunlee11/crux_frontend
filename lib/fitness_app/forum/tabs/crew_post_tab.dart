import 'package:best_flutter_ui_templates/fitness_app/forum/forum_post_detail.dart';
import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/post_detail_tab.dart';
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_crew_post_list_data.dart';
import '../../providers/forum_crew_post_list_provider.dart';
import '../widgets/crew_post_list.dart';
import '../widgets/post_list.dart';
import 'crew_detail.tab.dart';

int docID = 0;
int getID = 0;

class ForumCrewPostTab extends StatelessWidget {
  final Function(int) onTapCallback;

  ForumCrewPostTab({required this.onTapCallback});

int getdocID() {

  getID = docID;
  return getID;
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ForumCrewPostProvider>(

        builder: (context,value,child)=> ForumCrewPostList(
          forumcrewpostlist: value.allPosts
        ),
      ),
      );
  }
}

