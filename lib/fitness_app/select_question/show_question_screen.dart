import 'package:best_flutter_ui_templates/fitness_app/models/meals_list_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/select_question/climbingVideo_list_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/select_question/questions_list_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/ui_view/title_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/videoPlayer_view/videoPlayer_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/sector_list_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen_inShow.dart';
import 'package:dio/dio.dart';
import '../providers/user_mypage_provider.dart';
import '../models/user.dart';

// 재준 : 문제를 볼 수 잇는 화면 구현-> 해당 화면에 필요현 list_view, model도 구현
class ShowQuestionScreen extends StatefulWidget {
  const ShowQuestionScreen({
    Key? key,
    this.animationController,
    required this.sectorNum,
    required this.questionColor,
    required this.colorNum,
    required this.userId,
    required this.userNickname,
  }) : super(key: key);

  final AnimationController? animationController;
  final int sectorNum;
  final String questionColor;
  final int colorNum;
  final String userId;
  final String userNickname;

  @override
  _ShowQuestionScreenState createState() => _ShowQuestionScreenState();
}

class _ShowQuestionScreenState extends State<ShowQuestionScreen>
    with TickerProviderStateMixin {
  String BACKENDURL = "61.98.244.12:8000";
  Animation<double>? topBarAnimation;
  List<SectorListData> sectorList = SectorListData.sectorList;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  final List<PlatformFile> _files = [];
  UserProvider userProvider = UserProvider();
  void _pickFiles() async {
    List<PlatformFile>? uploadedFiles = (await FilePicker.platform.pickFiles(
      allowMultiple: true,
    ))
        ?.files;
    setState(() {
      for (PlatformFile file in uploadedFiles!) {
        _files.add(file);
      }
    });
  }

  Future<Widget> _getImage(int id, String questionColor) async {
    String urlString = "http://$BACKENDURL/sector/$id";
    Uri uri = Uri.parse(urlString);
    try {
      final response = await http.get(uri);
      final List<dynamic> responseData =
          jsonDecode(utf8.decode(response.bodyBytes));
      final Map<String, dynamic> firstItem = responseData[0];
      String url = firstItem['sectorimage'];
      if (questionColor == "") {
        String urlString2 = "http://$BACKENDURL$url";
        return Image.network(urlString2, fit: BoxFit.cover);
      } else {
        url = url.substring(7);
        String urlString2 =
            "http://$BACKENDURL/media/exp/$id/$questionColor$url";
        Uri uri2 = Uri.parse(urlString2);
        final response2 = await http.get(uri2);
        if (response2.statusCode == 200) {
          return Image.network(urlString2, fit: BoxFit.cover);
        } else {
          return Image.asset(
            'assets/fitness_app/noproblem.png',
            fit: BoxFit.cover,
          );
        }
      }
    } catch (e) {
      // 이미지 로드에 실패한 경우 기본 이미지 반환
      return Image.asset(
        'assets/fitness_app/noproblem.png',
        fit: BoxFit.cover,
      );
    }
  }

  void uploadVideo(String youtubeUrl, int count, String userId) async {
    try {
      String url = 'http://$BACKENDURL/post-video';
      FormData formData = FormData.fromMap({
        'videoid': 10000 * widget.sectorNum + 100 * widget.colorNum + count,
        'uploaddate': 10000 * widget.sectorNum + 100 * widget.colorNum + count,
        'videourl': youtubeUrl
      });

      Response response = await Dio().post(url, data: formData);

      if (response.statusCode == 201) {
        User? user = await userProvider.fetchUserInfo(userId);
        if (user != null) {
          userProvider.updateEXP(userId, user.recentqueue + 10);
        }
      } else {
        uploadVideo(youtubeUrl, count + 1, userId);
      }
    } catch (e) {
      uploadVideo(youtubeUrl, count + 1, userId);
    }
  }

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    listViews.add(
      const SizedBox(
        width: 100,
        height: 30,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: sectorList[(widget.sectorNum % 10) - 1].titleTxt,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      AspectRatio(
        aspectRatio: 9 / 16, // 예: 가로:세로 종횡비 16:9
        child: FutureBuilder<Widget>(
          future: _getImage(widget.sectorNum, widget.questionColor),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}'); // 에러 메시지를 출력하여 확인
              return Image.asset(
                'assets/fitness_app/noproblem.png', // 이미지 파일의 경로
                fit: BoxFit.cover,
              );
            } else {
              return snapshot.data ??
                  Image.asset(
                    'assets/fitness_app/noproblem.png', // 이미지 파일의 경로
                    fit: BoxFit.cover,
                  );
            }
          },
        ),
      ),
    );

    listViews.add(
      questionListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: const Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
        centerNum: widget.sectorNum,
        questionColor: widget.questionColor,
        userId: widget.userId,
        userNickname: widget.userNickname,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: '문제 동영상',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0,
                curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      ClimbingVideoListView(
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: const Interval((1 / count) * 3, 1.0,
                      curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController,
          vedioID: (10000 * widget.sectorNum + 100 * widget.colorNum)),
    );
    listViews.add(
      Container(
        padding: const EdgeInsets.only(right: 16), // Add right padding
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // Show a dialog to enter a YouTube URL
              showDialog(
                context: context,
                builder: (context) {
                  String youtubeUrl = ""; // Variable to store the URL

                  return AlertDialog(
                    title: const Text("Enter YouTube URL"),
                    content: TextField(
                      onChanged: (value) {
                        youtubeUrl = value;
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          uploadVideo(youtubeUrl, 0, widget.userId);
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FitnessAppHomeScreenInShow(
                                        centerNum: widget.sectorNum,
                                        questionColor: widget.questionColor,
                                        colorNum: widget.colorNum,
                                        userId: widget.userId,
                                        userNickname: widget.userNickname,
                                      )));
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                FontAwesomeIcons.circlePlus,
                color: HexColor("#33CC33"),
                size: 44,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            const SizedBox(
              width: 100,
              height: 300,
            ),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(width: 130),
                                    Text(
                                      'CRUX',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22 + 6 - 6 * topBarOpacity,
                                        letterSpacing: 1.2,
                                        color: FitnessAppTheme.darkerText,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            30), // Add some spacing between "CRUX" and user info
                                    Column(
                                      children: [
                                        Text(
                                          '아이디: ${widget.userId}',
                                          style: const TextStyle(
                                            color: FitnessAppTheme.darkerText,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          '닉네임: ${widget.userNickname}',
                                          style: const TextStyle(
                                            color: FitnessAppTheme.darkerText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
