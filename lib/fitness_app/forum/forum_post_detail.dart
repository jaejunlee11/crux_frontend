import 'package:best_flutter_ui_templates/fitness_app/forum/forum_new_post_page.dart';
import 'package:flutter/material.dart';
import 'tabs/post_detail_tab.dart';

/*

class ForumDetailScreen extends StatefulWidget {

final int docID;
ForumDetailScreen(this.docID);

  @override
  _ForumDetailScreenState createState() => _ForumDetailScreenState();
}

class _ForumDetailScreenState extends State<ForumDetailScreen> 
with SingleTickerProviderStateMixin{  // 단일 애니메이션 위젯 정의 시 사용함
  late TabController controller; //차후 확인 (late)
  @override
  void initState(){
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 확인'),
        backgroundColor: Colors.green,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0,0.0,40.0,0.0),
          child: IconButton(
            icon: Icon(
            Icons.reorder,  
            color: Colors.white,
            size: 50.0),
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPostScreen()),
                );
            },
            ),
        ),
      ],
      bottom: TabBar(
      controller : controller,
      tabs: <Widget>[
      ],
      ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ForumPostDetail(widget.docID),                               // 게시글 id를 받아오기
        ],
      ),
          );
     
  }
}

*/