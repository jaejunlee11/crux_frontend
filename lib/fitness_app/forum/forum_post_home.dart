import 'package:best_flutter_ui_templates/fitness_app/forum/forum_new_post_page.dart';
import 'package:flutter/material.dart';
import 'tabs/post_tab.dart';
import 'tabs/post_like_tab.dart';

class ForumHomeScreen extends StatefulWidget {
  int docID = 0;

  ForumHomeScreen({super.key}); //default id

  @override
  _ForumHomeScreenState createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen>
    with SingleTickerProviderStateMixin {
  // 단일 애니메이션 위젯 정의 시 사용함
  late TabController controller; //차후 확인 (late)
  int _currentTabIndex = 1;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  void setDocID(int id) {
    // Update the docID when called by the child widget
    setState(() {
      widget.docID = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 확인 / 자유 게시판'),
        backgroundColor: Colors.green,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: const <Widget>[
            Tab(
              child: Icon(
                Icons.star_border,
                color: Colors.blue,
//                    text: '모든글 보기'
              ),
            ),
            Tab(
              child: Icon(
                Icons.star,
                color: Colors.blue,
                //                   text: '추천글 보기'
              ),
            ),
            Tab(
              child: Icon(
                Icons.create,
                color: Colors.black,
                //                   text: '작성하기'
              ),
            ),
          ],
          onTap: (index) async {
            if (index == 2) {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewPostScreen()));
            } else {
              setState(() {
                _currentTabIndex = index;
              });
            }
          },
        ),
      ),
      body: TabBarView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          _currentTabIndex == 0
              ? ForumPostTab(onTapCallback: setDocID)
              : Container(),
          _currentTabIndex == 1
              ? ForumLikeTab(onTapCallback: setDocID)
              : Container(),
        ],
      ),
    );
  }
}

/*
import 'package:best_flutter_ui_templates/fitness_app/forum/forum_new_post_page.dart';
import 'package:flutter/material.dart';
import 'tabs/post_tab.dart';

class ForumHomeScreen extends StatefulWidget {

int docID = 0; //default id  

  @override
  _ForumHomeScreenState createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen> 
with SingleTickerProviderStateMixin{  // 단일 애니메이션 위젯 정의 시 사용함
  late TabController controller; //차후 확인 (late)
  @override
  void initState(){
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

    void setDocID(int id) {
    // Update the docID when called by the child widget
    setState(() {
      widget.docID = id;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 확인 / 자유 게시판'),
        backgroundColor: Colors.green,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0,0.0,40.0,0.0),
        ),
      ],
      bottom: TabBar(
      controller : controller,
      tabs: <Widget>[
        Tab(
          child:InkWell(
                onTap: () {print('Icon pressed');},
                child: Icon(
                    Icons.star,
                    color: Colors.blue,
//                    text: '추천글 보기'
                  ),
          ),
        ),
        Tab(
          child:InkWell(
                onTap: () {print('Icon pressed');},
                child: Icon(
                    Icons.star_border,
                    color: Colors.blue,
 //                   text: '모든 글 보기'
                  ),
          ),
        ),
        Tab(
          child:InkWell(
                onTap: () {                
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPostScreen()));},
                child: Icon(
                    Icons.create,
                    color: Colors.black,
 //                   text: '작성하기'
                  ),
          ),
        ),
      ],
      ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ForumPostTab(onTapCallback: setDocID),
        ],
      ),
          );
     
  }
}

*/
