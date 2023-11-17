import 'package:best_flutter_ui_templates/fitness_app/forum/forum_new_post_page.dart';
import 'package:best_flutter_ui_templates/fitness_app/forum/tabs/crew_post_tab.dart';
import 'package:flutter/material.dart';
import 'forum_crew_new_post_page.dart';
import 'tabs/crew_like_tab.dart';

class ForumCrewHomeScreen extends StatefulWidget {
  int docID = 0;

  ForumCrewHomeScreen({super.key}); //default id

  @override
  _ForumCrewHomeScreenState createState() => _ForumCrewHomeScreenState();
}

class _ForumCrewHomeScreenState extends State<ForumCrewHomeScreen>
    with SingleTickerProviderStateMixin {
  // 단일 애니메이션 위젯 정의 시 사용함
  late TabController controller; //차후 확인 (late)
  int _currentTabIndex = 0;
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
        title: const Text('게시글 확인 / 크루 모집 게시판'),
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
                Icons.person,
                color: Colors.black,
//                    text: '전체글 보기'
              ),
            ),
            Tab(
              child: Icon(
                Icons.person_outline,
                color: Colors.black,
                //                   text: '모집 진행중 글 보기'
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
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPostCrewScreen()));
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
              ? ForumCrewPostTab(onTapCallback: setDocID)
              : Container(),
          _currentTabIndex == 1
              ? ForumCrewLikeTab(onTapCallback: setDocID)
              : Container(),
        ],
      ),
    );
  }
}
