
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_post_list_data.dart';
import '../widgets/post_list.dart';
import 'package:intl/intl.dart';


class ForumPostDetail extends StatelessWidget {
  final int docID;
  Color titlecolor = Color(0xff92BEA9);
  Color pagecolor = Color(0xffC5DEDA);


  ForumPostDetail(this.docID);

  @override
  Widget build(BuildContext context) {
    return Consumer<ForumPostProvider>(
      builder: (context, value, child) {

        ForumPost specificPost = value.allPosts.firstWhere(
          (post) => post.documentnum == docID,
          orElse: () => ForumPost(documentnum: 0, title: "Post not found", content: "Post not found", username:"0", like: 0, dislike: 0, postdate: DateFormat("yyyy-MM-dd").format(DateTime.now())),
        );

        return Container(
          decoration: BoxDecoration(
            color: pagecolor,
            border: Border.all(color: Colors.black, width: 1.0),

          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0,50.0,0.0,70.0),
          child: Column(
            children: [
              Column(
              children: [ 
              Container(
              decoration: BoxDecoration(
              color: titlecolor,
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(30),
              ),  
              child:  
              Text("Post Title: ${specificPost.title}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Arial',
                  ),
              ),
              ),
              ],
              ),
              const SizedBox(height:15),

            Expanded(
              child:Align(
                alignment: Alignment.center,
                child:Text("Post Content: ${specificPost.content}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Arial',
                  )
                ),
              ),
            ),
              const SizedBox(height:15),

              Align(alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 
              ElevatedButton(onPressed: specificPost.pluslike , child: Text("Like"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green))),
              ElevatedButton(onPressed: specificPost.plusdislike, child: Text("Dislike"), style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green))),
              ]
              ),
              ),
            ],
          ),
        ),
        );
      },
    );
  }
}

void pluslike(ForumPost post){
  post.like++;
}

void plusdislike(ForumPost post){
  post.dislike++;
}


