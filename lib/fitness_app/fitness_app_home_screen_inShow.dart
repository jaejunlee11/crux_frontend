import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/select_question/show_question_screen.dart';

import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fitness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';
import 'select_question/select_question_screen.dart';
import 'forum/forum_page.dart';
import 'forum/forum_crew_page.dart';
import 'forum/my_page.dart';

class FitnessAppHomeScreenInShow extends StatefulWidget {
  final int centerNum;
  final String questionColor;
  final int colorNum;
  final String userId;
  final String userNickname;

  const FitnessAppHomeScreenInShow({
    Key? key,
    required this.centerNum,
    required this.questionColor,
    required this.colorNum,
    required this.userId,
    required this.userNickname,
  }) : super(key: key);

  @override
  _FitnessAppHomeScreenInShowState createState() =>
      _FitnessAppHomeScreenInShowState();
}

class _FitnessAppHomeScreenInShowState extends State<FitnessAppHomeScreenInShow>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = ShowQuestionScreen(
      animationController: animationController,
      sectorNum: widget.centerNum,
      questionColor: widget.questionColor,
      colorNum: widget.colorNum,
      userId: widget.userId,
      userNickname: widget.userNickname,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 4) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyDiaryScreen(
                    animationController: animationController,
                    userId: widget.userId,
                    userNickname: widget.userNickname,
                  );
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = const ForumApp();
                });
              });
            } else if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = SelectQuestionScreen(
                      animationController: animationController,
                      userId: widget.userId,
                      userNickname: widget.userNickname);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyPage(
                    userId: widget.userId,
                    userNickname: widget.userNickname,
                  );
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = CrewForumApp();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
