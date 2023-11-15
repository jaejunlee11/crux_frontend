
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_crew_post_list_data.dart';
import '../../models/forum_post_list_data.dart';
import '../../providers/forum_crew_post_list_provider.dart';
import '../widgets/post_list.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForumCrewPostDetail extends StatelessWidget {
  final int docID;
  Color titlecolor = Color(0xff92BEA9);
  Color pagecolor = Color(0xffC5DEDA);

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
                      color:titlecolor,
                      border: Border.all(color: Colors.black,width: 2.0),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child:
                    Text("${specificPost.region} | ${specificPost.title}",
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
                  child:Text("${specificPost.content}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:20,
                    fontFamily: 'Arial',
                  )
                  ),
                ),
              ),
              const SizedBox(height:15),
            
              Align(alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  ElevatedButton(onPressed: () async {await value.likePost(docID); showApplyMessage();}, child: Text("현재 예상 인원: ${specificPost.like}/${specificPost.dislike}"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green))),
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



void showApplyMessage(){
  Fluttertoast.showToast(
    msg: '참가 표시를 했습니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
