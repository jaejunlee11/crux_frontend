import 'dart:io';

import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/forum_crew_post_list_data.dart';
import '../models/forum_post_list_data.dart';
import '../providers/forum_crew_post_list_provider.dart';
import 'forum_crew_post_home.dart';
import 'package:intl/intl.dart';
import 'forum_crew_page.dart';

// 민재 : 게시판에서 글 작성 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class NewPostCrewScreen extends StatefulWidget {
  const NewPostCrewScreen({super.key});

  @override
  _NewPostCrewScreenState createState() => _NewPostCrewScreenState();
}

class _NewPostCrewScreenState extends State<NewPostCrewScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _member = '';
  String _region = 'null';
  int membernum = 0;
  late DateTime now;
  int defaultid = 600;
  int defaultnum = 0;

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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Maximum Members',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Maximum number of Members';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _member = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String?>(
                  decoration: const InputDecoration(
                    labelText: '지역',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.green),
                  ),
                  onChanged: (String? newValue) {
                    _region = newValue ?? 'null';
                    print(newValue);
                  },
                  items: [null, 'InCheon', 'Seoul', 'Gyeonggi']
                      .map<DropdownMenuItem<String?>>((String? i) {
                    return DropdownMenuItem<String?>(
                      value: i,
                      child: Text(i == null
                          ? 'Select'
                          : {
                              'InCheon': '인천',
                              'Seoul': '서울',
                              'Gyeonggi': '경기'
                            }[i]!),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
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
                        membernum = int.parse(_member);
                        final newcrewpost = ForumCrewPost(
                            title: _title,
                            content: _content,
                            region: _region,
                            documentnum: id,
                            username: 'test',
                            postdate: time,
                            like: 1,
                            dislike: membernum); //username, postdate 수정 요구
                        defaultid++;
                        final forumcrewPostProvider =
                            Provider.of<ForumCrewPostProvider>(context,
                                listen: false);
                        forumcrewPostProvider.addPost(newcrewpost);
                        showCompleteMessage();
                        Navigator.pop(
                          context,
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CrewForumApp()));
                        sleep(const Duration(seconds: 1));
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
