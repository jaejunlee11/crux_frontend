import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/forum_post_list_data.dart';
import 'forum_post_home.dart';

// 민재 : 게시판에서 글 작성 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  int defaultid= 300;
  int defaultnum = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        backgroundColor: Colors.green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
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
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  final newpost = ForumPost(title: _title, content: _content, documentnum:defaultid,username:'test',postdate:'2020-02-01',like:0,dislike:0); //username, postdate 수정 요구
                  defaultid++;
                  final forumPostProvider = Provider.of<ForumPostProvider>(context, listen: false);
                  forumPostProvider.addPost(newpost);
                  showCompleteMessage(); 
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForumHomeScreen()),
                  );


                  }
                },
                child: Text('Create Post'),
                style: ElevatedButton.styleFrom(                  
                    backgroundColor: Colors.green,                  
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCompleteMessage(){
  Fluttertoast.showToast(
    msg: '게시글 작성 완료',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}