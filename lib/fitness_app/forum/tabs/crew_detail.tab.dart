
import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_crew_post_list_data.dart';
import '../../models/forum_post_list_data.dart';
import '../../providers/forum_crew_post_list_provider.dart';
import '../widgets/post_list.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'crew_detail_tab_modify.dart';


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
          orElse: () => ForumCrewPost(documentnum: 0, title: "삭제된 글입니다", content: "삭제된 글입니다", username:"0",region:'없음' ,like: 0, dislike: 0, postdate: DateFormat("yyyy-MM-dd").format(DateTime.now())),
        );

        return         
        Container(
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
              Row(
                children: [
                // Add your delete and change icons here
                  IconButton(
                    onPressed: () {
                      showDeleteConfirmation(context,specificPost.documentnum,value);
                      },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                  IconButton(
                     onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForumCrewPostDetailModify(specificPost: specificPost)),
                );
                      },
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
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
            


              Padding( 
              padding: EdgeInsets.only(bottom: 10.0), // Adjust the value as needed

              child: Align(alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  ElevatedButton(onPressed: () async {await value.likePost(docID); showApplyMessage();}, child: Text("현재 예상 인원: ${specificPost.like}/${specificPost.dislike}"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green))),
                ]
              ),
              ),
              ),
            ],
          ),
        )
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

void showDeleteMessage(){
  Fluttertoast.showToast(
    msg: '글을 삭제했습니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );

}

Future<void> showDeleteConfirmation(BuildContext context, int docID,ForumCrewPostProvider value) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('삭제 확인'),
        content: Text('정말 이 글을 지우시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              await value.deletePost(docID);
              Navigator.of(context).pop(); // Close the dialog
              showDeleteMessage();// Optionally, pop the current screen after deletion
            },
            child: Text('삭제'),
          ),
        ],
      );
    },
  );
}

