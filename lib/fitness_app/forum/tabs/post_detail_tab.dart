//import 'dart:js';

import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:best_flutter_ui_templates/fitness_app/videoPlayer_view/videoPlayer_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/forum_post_list_data.dart';
import '../widgets/post_list.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'post_detail_tab_modify.dart';

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
          orElse: () => ForumPost(
              documentnum: 0,
              title: "삭제된 글입니다",
              content: "삭제된 글입니다",
              username: "0",
              like: 0,
              dislike: 0,
              postdate: DateFormat("yyyy-MM-dd").format(DateTime.now())),
        );
        
    Future<void> _showVideoURLPopup(String text) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('동영상 URL 확인하기'),
          content: Text('$text'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }




        return Container(
          decoration: BoxDecoration(
            color: pagecolor,
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 70.0),
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
                      child: Text(
                        "${specificPost.title}",
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
                    IconButton(
                      onPressed: () {
                        showDeleteConfirmation(
                            context, specificPost.documentnum, value);
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForumPostDetailModify(
                                  specificPost: specificPost)),
                        );
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("${specificPost.content}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Arial',
                        )),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 25.0), 

                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                await value.likePost(docID);
                                showLikeMessage();
                              },
                              child: Text("Like: ${specificPost.like}"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green))),
                          ElevatedButton(
                              onPressed: () async {
                                await value.dislikePost(docID);
                                showDislikeMessage();
                              },
                              child: Text("Dislike: ${specificPost.dislike}"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green))),
                        ]),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:30, right: 10),
                    child: specificPost.VidURL != null &&
                            specificPost.VidURL!.isNotEmpty
                        ? Row(
                        mainAxisSize: MainAxisSize.min,                        
                        children: [
                          GestureDetector(
                            onTap:(){
                              _showVideoURLPopup('${specificPost.VidURL}');
                            },

                          child: Text(
                          '이 게시글에는 연결된 동영상이 있습니다. URL 보기 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'Arial',
                            ),
                          ),
                          ),

                          Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            color: Colors.white,
                          ),                        
                        child: IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                   //fullscreenDialog: true,
                                   //넘어가는 VideoPlayerScreen 하단 바 포함하도록 할 수는 없는가?
                                    builder: (context) => VideoPlayerScreen(
                                          videoId: specificPost.VidURL!,
                                          userId: specificPost.username,
                                          userNickname: '',
                                        )),
                              );
                            },
                            color: Colors.green,
                          ),
                          ),
                        ],
                        )
                        : SizedBox()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void showLikeMessage() {
  Fluttertoast.showToast(
    msg: '좋아요를 눌렀습니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void showDislikeMessage() {
  Fluttertoast.showToast(
    msg: '싫어요를 눌렀습니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

void showDeleteMessage() {
  Fluttertoast.showToast(
    msg: '글을 삭제했습니다',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

Future<void> showDeleteConfirmation(
    BuildContext context, int docID, ForumPostProvider value) async {
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
              showDeleteMessage(); // Optionally, pop the current screen after deletion
            },
            child: Text('삭제'),
          ),
        ],
      );
    },
  );
}
