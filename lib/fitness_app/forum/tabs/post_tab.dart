import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../widgets/post_list.dart';

class PostTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ForumPostProvider>(
        builder: (context,value,child)=> PostList(
          postlist: value.allPosts
        ),
      ),

    );
  }
}