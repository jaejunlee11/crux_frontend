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
                    Icons.favorite,
                    color: Colors.red,
//                    text: '즐겨찾기'
                  ),
          ),
        ),
        Tab(
          child:InkWell(
                onTap: () {print('Icon pressed');},
                child: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
 //                   text: '추천글'
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



