import 'package:best_flutter_ui_templates/fitness_app/models/meals_list_data.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/videoPlayer_view/videoPlayer_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClimbingVideoListView extends StatefulWidget {
  const ClimbingVideoListView(
      {Key? key,
      this.mainScreenAnimationController,
      this.mainScreenAnimation,
      required this.vedioID})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;
  final int vedioID;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<ClimbingVideoListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

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
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: mealsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      mealsListData.length > 10 ? 10 : mealsListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealsView(
                    mealsListData: mealsListData[index],
                    animation: animation,
                    animationController: animationController!,
                    videoID: widget.vedioID,
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

class MealsView extends StatelessWidget {
  const MealsView(
      {Key? key,
      this.mealsListData,
      this.animationController,
      this.animation,
      required this.videoID})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int videoID;

  Future<Image> _getImage(int id) async {
    String urlString = "http://0.0.0.0:8000/sector/$id";
    Uri uri = Uri.parse(urlString);
    final response = await http.get(uri);
    final List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> firstItem = responseData[0];
    String url = firstItem['sectorimage'];
    String urlString2 = "http://0.0.0.0:8000$url";
    return Image.network(urlString2, fit: BoxFit.cover);
  }

  Future<String> getThumbnailUrl(int videoID, int sectorNum) async {
    // 동영상 ID와 sectorNum을 조합하여 URL 생성
    String urlString = "http://0.0.0.0:8000/video/${videoID + sectorNum}";
    final Uri uri = Uri.parse(urlString);
    final response = await http.get(uri);
    final List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> firstItem = responseData[0];
    final String url = firstItem['videourl'];
    // URL을 반환
    return url;
  }

  Future<Image> getYouTubeVideoThumbnail(int videoID, int sectorNum) async {
    String videoUrl = "";
    try {
      videoUrl = await getThumbnailUrl(videoID, sectorNum);
    } catch (e) {
      print("error 주소");
      return Image.asset(mealsListData!.imagePath);
    }
    try {
      videoUrl = videoUrl.substring(27, 38);
      return Image.network("https://img.youtube.com/vi/$videoUrl/0.jpg");
    } catch (e) {
      return Image.asset(mealsListData!.imagePath);
    }
  }

  Future<String> getVideoId(int id) async {
    final urlString = "http://0.0.0.0:8000/video/$id";
    final Uri uri = Uri.parse(urlString);
    final response = await http.get(uri);
    final List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> firstItem = responseData[0];
    final String url = firstItem['videourl'];
    return url.substring(27, 38);
  }

  void navigateToVideoPlayerScreen(BuildContext context) async {
    String videoId = await getVideoId(videoID + mealsListData!.sectornum);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoId: videoId),
      ),
    );
  }

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
            child: GestureDetector(
              onTap: () {
                navigateToVideoPlayerScreen(context);
              },
              child: SizedBox(
                width: 200,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 8, right: 8, bottom: 16),
                      child: Positioned(
                        top: 0,
                        left: 0,
                        child: SizedBox(
                          width: 200,
                          height: 300,
                          child: FutureBuilder<Image>(
                            future: getYouTubeVideoThumbnail(
                                videoID, mealsListData!.sectornum),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Image.asset(mealsListData!.imagePath);
                                } else {
                                  return snapshot.data!;
                                }
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
