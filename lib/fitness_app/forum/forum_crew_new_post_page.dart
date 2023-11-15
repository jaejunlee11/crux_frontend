import 'package:best_flutter_ui_templates/fitness_app/providers/forum_post_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/forum_crew_post_list_data.dart';
import '../models/forum_post_list_data.dart';
import '../providers/forum_crew_post_list_provider.dart';
import 'forum_crew_post_home.dart';


// 민재 : 게시판에서 글 작성 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class NewPostCrewScreen extends StatefulWidget {
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
  int defaultid= 600;
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
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                decoration: InputDecoration(
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




              SizedBox(height: 16.0),
              DropdownButtonFormField<String?>(
              decoration: InputDecoration(
                labelText: '지역',
                labelStyle: TextStyle(fontSize: 15, color: Colors.green),
              ),
              onChanged: (String? newValue) {
                _region = newValue ?? 'null';
                print(newValue);
              },
              items:
                  [null, 'InCheon', 'Seoul','Gyeonggi'].map<DropdownMenuItem<String?>>((String? i) {
                return DropdownMenuItem<String?>(
                  value: i,
                  child: Text(i == null ? 'Select' : {'InCheon': '인천', 'Seoul': '서울','Gyeonggi':'경기'}[i]!),
                );
              }).toList(),
            ),



              SizedBox(height: 16.0),              
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  membernum = int.parse(_member);
                  final newcrewpost = ForumCrewPost(title: _title, content: _content,region: _region ,documentnum:defaultid,username:'test',postdate:'2020-02-01',like:1,dislike:membernum); //username, postdate 수정 요구
                  defaultid++;
                  final forumcrewPostProvider = Provider.of<ForumCrewPostProvider>(context, listen: false);
                  forumcrewPostProvider.addPost(newcrewpost);
                  showCompleteMessage(); 
                  Navigator.pop(
                  context,
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
