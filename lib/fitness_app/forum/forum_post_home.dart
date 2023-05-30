import 'package:flutter/material.dart';
import 'tabs/post_tab.dart';

class ForumHomeScreen extends StatefulWidget {

  @override
  State<ForumHomeScreen> createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen> 
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
        title: Text('자유 게시판 메인'),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0,0.0,40.0,0.0),
          child: IconButton(
            icon: Icon(
            Icons.add,  
            color: Colors.white,
            size: 50.0),
            onPressed: (){},),
        ),
      ],
      bottom: TabBar(
      controller : controller,
      tabs: <Widget>[
        Tab(icon: Icon(Icons.favorite,color: Colors.red),text: '즐겨찾기'),],
      ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          PostTab(),
        ],
      ),
          );
     
  }
}