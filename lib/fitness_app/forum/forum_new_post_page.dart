import 'package:flutter/material.dart';

// 민재 : 게시판에서 글 작성 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
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

                    // Add code to create a new post here
                    // You can use the _title and _content variables to access the user's input
                  }
                },
                child: Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
