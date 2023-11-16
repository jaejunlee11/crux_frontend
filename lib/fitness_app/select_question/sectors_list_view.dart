import 'dart:io';

import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen_inShow.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/sector_list_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/hotel_app_theme.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SectorsListView extends StatefulWidget {
  const SectorsListView({
    Key? key,
    this.sectorData,
    this.animationController,
    this.animation,
    this.callback,
    required this.userId,
    required this.userNickname,
  }) : super(key: key);

  final VoidCallback? callback;
  final SectorListData? sectorData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final String userId;
  final String userNickname;

  @override
  _SectorsListViewState createState() => _SectorsListViewState();
}

class _SectorsListViewState extends State<SectorsListView> {
  final ImagePicker _picker = ImagePicker();
  // File? _image;
  File? _image;
  dynamic sendData;
  String BACKENDURL = "0.0.0.0:8000";
  // List<File> _files = [];
  Future<void> getImage() async {
    final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 100 //0-100
        );
    if (file?.path != null) {
      setState(() {
        _image = File(file!.path);
        sendData = _image!.path;
      });
    }
  }

  void _uploadImage(String a, int b) async {
    await getImage();
    print("upload");
    print(sendData);
    try {
      // String url = 'http://0.0.0.0:8000/post-sector';
      String url = 'http://$BACKENDURL/update-sector/$b';
      String fileName = "$a.jpg";
      FormData formData = FormData.fromMap({
        'sectorimage':
            (MultipartFile.fromFileSync(sendData, filename: fileName)),
        'sectornum': b,
      });
      Response response = await Dio().put(url, data: formData);
      // Response response = await Dio().post(url, data: formData);

      if (response.statusCode == 201) {
        print('Image uploaded successfully.');
      } else {
        print('Failed to upload image.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // void _getImage(int id) async {
  //   String urlString = "http://0.0.0.0:8000/sector/$id";
  //   Uri uri = Uri.parse(urlString);
  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> responseData =
  //         jsonDecode(utf8.decode(response.bodyBytes));

  //     // Check if responseData is not empty and contains at least one map
  //     if (responseData.isNotEmpty && responseData[0] is Map<String, dynamic>) {
  //       final Map<String, dynamic> firstItem = responseData[0];
  //       _image = firstItem['sectorimage'];
  //     } else {
  //       print('Response data is not in the expected format.');
  //     }
  //   } else {
  //     print("오류");
  //   }

  Future<Widget> _getImage(int id) async {
    String urlString = "http://$BACKENDURL/sector/$id";
    Uri uri = Uri.parse(urlString);
    final response = await http.get(uri);
    final List<dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));
    final Map<String, dynamic> firstItem = responseData[0];
    String url = firstItem['sectorimage'];
    String urlString2 = "http://$BACKENDURL$url";
    return Image.network(urlString2, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - widget.animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                // onTap:
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FitnessAppHomeScreenInShow(
                                          centerNum: widget.sectorData!.num,
                                          questionColor: "",
                                          colorNum: 0,
                                          userId: widget.userId,
                                          userNickname: widget.userNickname,
                                        )));
                          },
                          child: Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: _image != null
                                    ? Image.file(_image!, fit: BoxFit.cover)
                                    // : Image.asset(
                                    //     widget.sectorData!.imagePath,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    : FutureBuilder<Widget>(
                                        future:
                                            _getImage(widget.sectorData!.num),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Widget> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return snapshot.data ??
                                                Image.asset(
                                                  'path_to_placeholder_image',
                                                  fit: BoxFit.cover,
                                                );
                                          }
                                        },
                                      ),
                              ),
                              Container(
                                color: HotelAppTheme.buildLightTheme()
                                    .colorScheme
                                    .background,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                widget.sectorData!.titleTxt,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              // Row(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.center,
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.start,
                                              //   children: <Widget>[
                                              // Text(
                                              //   sectorData!.subTxt,
                                              //   style: TextStyle(
                                              //       fontSize: 14,
                                              //       color: Colors.grey
                                              //           .withOpacity(0.8)),
                                              // ),
                                              // const SizedBox(
                                              //   width: 4,
                                              // ),
                                              // Icon(
                                              //   FontAwesomeIcons
                                              //       .solidCircle,
                                              //   size: 12,
                                              //   color: sectorData!.rating ==
                                              //           1
                                              //       ? Colors.white
                                              //       : sectorData!.rating ==
                                              //               2
                                              //           ? Colors.yellow
                                              //           : sectorData!
                                              //                       .rating ==
                                              //                   3
                                              //               ? Colors.green
                                              //               : sectorData!
                                              //                           .rating ==
                                              //                       4
                                              //                   ? Colors
                                              //                       .blue
                                              //                   : sectorData!.rating ==
                                              //                           5
                                              //                       ? Colors
                                              //                           .red
                                              //                       : sectorData!.rating ==
                                              //                               6
                                              //                           ? Colors.purple
                                              //                           : Colors.grey,
                                              // ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      //여기?
                                      padding:
                                          EdgeInsets.only(right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {
                                // 이미지가 선택된 경우에만 작동
                                _uploadImage(widget.sectorData!.imagePath,
                                    widget.sectorData!.num); // 이미지 업로드 함수 호출
                                // _getImage(2);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Icon(
                                  Icons.change_circle,
                                  color: Colors.purple,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
