import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:best_flutter_ui_templates/fitness_app/forum/forum_new_post_page.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen(
      {Key? key,
      required this.videoId,
      required this.userId,
      required this.userNickname})
      : super(key: key);
  final String videoId;
  final String userId;
  final String userNickname;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     loadVideo();
//   }

//   void loadVideo() async {
//     final videoId = widget.videoId;

//     if (videoId.isEmpty) {
//       // 값이 없을 경우, 이전 화면으로 돌아감
//       Navigator.pop(context);
//     } else {
//       _controller = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//         ),
//       );
//       setState(() {}); // Update the state to rebuild the widget
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const aspectRatio = 9 / 16;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.width / aspectRatio,
//                 child: YoutubePlayerBuilder(
//                   player: YoutubePlayer(
//                     controller: _controller,
//                   ),
//                   builder: (context, player) {
//                     return player;
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => NewPostScreen(
//                             userid: widget.userId,
//                             videoURL: widget.videoId,
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                     ),
//                     child: const Text('게시글 작성하기'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         backgroundColor: Colors.green,
//         child: const Icon(
//           Icons.arrow_back,
//         ),
//       ),
//     );
//   }
// }
class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    loadVideo();
  }

  void loadVideo() async {
    final videoId = widget.videoId;

    if (videoId.isEmpty) {
      // 값이 없을 경우, 이전 화면으로 돌아감
      Navigator.pop(context);
    } else {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      setState(() {}); // Update the state to rebuild the widget
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const aspectRatio = 9 / 16;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 900.0, // Set the total height you desire for the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height:
                    550.0, // Set the height you desire for the YoutubePlayer
                child: YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                  ),
                  builder: (context, player) {
                    return player;
                  },
                ),
              ),
              const SizedBox(
                height: 20.0, // Adjust the height based on your needs
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 100.0, // Adjust the width based on your needs
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPostScreen(
                            userid: widget.userId,
                            videoURL: widget.videoId,
                            whereyoufrom: 1
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('게시글 작성하기'),
                  ),
                  const SizedBox(
                    width: 50.0, // Adjust the width based on your needs
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
