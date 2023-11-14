
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_crew_post_list_data.dart';
import '../../models/forum_post_list_data.dart';
import '../../providers/forum_crew_post_list_provider.dart';
import '../widgets/post_list.dart';
import 'package:intl/intl.dart';


class ForumCrewPostDetail extends StatelessWidget {
  final int docID;

  ForumCrewPostDetail(this.docID);

  @override
  Widget build(BuildContext context) {
    return Consumer<ForumCrewPostProvider>(
      builder: (context, value, child) {

        ForumCrewPost specificPost = value.allPosts.firstWhere(
          (post) => post.documentnum == docID,
          orElse: () => ForumCrewPost(documentnum: 0, title: "Post not found", content: "Post not found", username:"0",region:'none' ,like: 0, dislike: 0, postdate: DateFormat("yyyy-MM-dd").format(DateTime.now())),
        );

        return Container(
          child: Column(
            children: [
              Text("Post Title: ${specificPost.title}"),
              Text("Post Content: ${specificPost.content}"),
              Text("Post Region: ${specificPost.region}"),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(45),
            ),
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
        );
      },
    );
  }
}
