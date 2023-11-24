import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:best_flutter_ui_templates/fitness_app/providers/user_mypage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/forum_post_list_data.dart';
import 'forum_post_home.dart';
import 'package:intl/intl.dart';
import 'forum_crew_post_home.dart';
import 'forum_page.dart';
import 'dart:io';

// 민재 : 게시판에서 글 작성 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class NewPostScreen extends StatefulWidget {
  final String userid;
  String? videoURL;
  NewPostScreen({Key? key, required this.userid, this.videoURL})
      : super(key: key);

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _vidURL = '';
  late DateTime now;
  int defaultid = 300;
  int defaultnum = 0;
  int exp = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('New Post'), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some content';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _content = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: widget.videoURL ?? _vidURL,
                  decoration: const InputDecoration(
                    labelText: 'Option: VideoURL',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  /*validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Option: Please Enter Video URL';
                    }
                    return null;
                  },
                  */
                  onSaved: (value) {
                    setState(() {
                      _vidURL = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        now = DateTime.now();
                        String time = '${now.year}-${now.month}-${now.day}';
                        int id = defaultid +
                            now.month * 1000000 +
                            now.day * 10000 +
                            now.hour * 100 +
                            now.minute +
                            now.second;
                        final newpost = ForumPost(
                            title: _title,
                            content: _content,
                            documentnum: id,
                            VidURL: _vidURL,
                            username: widget.userid,
                            postdate: time,
                            like: 0,
                            dislike: 0); //username, postdate 수정 요구
                        defaultid++;
                        final forumPostProvider =
                            Provider.of<ForumPostProvider>(context,
                                listen: false);
                        await forumPostProvider.addPost(newpost);
                        showCompleteMessage();
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        await userProvider.updateEXP(widget.userid, exp);

                        Navigator.pop(context, true);
                        if (widget.videoURL != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForumApp(
                                        userid: widget.userid,
                                      )));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Create Post')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCompleteMessage() {
  Fluttertoast.showToast(
    msg: '게시글 작성 완료',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
