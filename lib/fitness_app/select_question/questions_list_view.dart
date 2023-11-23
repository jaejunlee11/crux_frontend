import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen_inShow.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/questions_list_data.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';

class questionListView extends StatefulWidget {
  const questionListView({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
    required this.centerNum,
    required this.questionColor,
    required this.userId,
    required this.userNickname,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final int centerNum;
  final String questionColor;
  final String userId;
  final String userNickname;
  @override
  _questionListViewState createState() => _questionListViewState();
}

class _questionListViewState extends State<questionListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<questionsListData> questionsData = questionsListData.tabIconsList;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: questionsData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      questionsData.length > 10 ? 10 : questionsData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return QuestionsView(
                    questionsData: questionsData[index],
                    animation: animation,
                    animationController: animationController!,
                    centerNum: widget.centerNum,
                    questionColor: widget.questionColor,
                    userId: widget.userId,
                    userNickname: widget.userNickname,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuestionsView extends StatelessWidget {
  const QuestionsView({
    Key? key,
    this.questionsData,
    this.animationController,
    this.animation,
    required this.centerNum,
    required this.questionColor,
    required this.userId,
    required this.userNickname,
  }) : super(key: key);

  final questionsListData? questionsData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int centerNum;
  final String questionColor;
  final String userId;
  final String userNickname;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 50,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: questionsData?.name == questionColor
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FitnessAppHomeScreenInShow(
                                            centerNum: centerNum,
                                            questionColor: questionsData!.name,
                                            colorNum: questionsData!.kacl,
                                            userId: userId,
                                            userNickname: userNickname,
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: HexColor(questionsData!.endColor)
                                        .withOpacity(0.6),
                                    offset: const Offset(1.1, 4.0),
                                    blurRadius: 8.0,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: <HexColor>[
                                    HexColor(questionsData!.startColor),
                                    HexColor(questionsData!.startColor),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 3, right: 3, bottom: 3),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        questionsData!.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      ),
                                      // Add a check mark Icon
                                      const Icon(
                                        Icons.check,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FitnessAppHomeScreenInShow(
                                            centerNum: centerNum,
                                            questionColor: questionsData!.name,
                                            colorNum: questionsData!.kacl,
                                            userId: userId,
                                            userNickname: userNickname,
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: HexColor(questionsData!.endColor)
                                        .withOpacity(0.6),
                                    offset: const Offset(1.1, 4.0),
                                    blurRadius: 8.0,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: <HexColor>[
                                    HexColor(questionsData!.startColor),
                                    HexColor(questionsData!.startColor),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 3, left: 3, right: 3, bottom: 3),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Text(
                                      //   questionsData!.name,
                                      //   textAlign: TextAlign.center,
                                      //   style: const TextStyle(
                                      //     fontFamily: FitnessAppTheme.fontName,
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 10,
                                      //     letterSpacing: 0.2,
                                      //     color: FitnessAppTheme.white,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
