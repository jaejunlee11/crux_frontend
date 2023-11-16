import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/forum_crew_post_list_data.dart';
import '../../providers/forum_crew_post_list_provider.dart';

class ForumCrewPostDetailModify extends StatefulWidget {
  final ForumCrewPost specificPost;

  ForumCrewPostDetailModify({required this.specificPost});

  @override
  _ForumCrewPostDetailModifyState createState() => _ForumCrewPostDetailModifyState();
}

class _ForumCrewPostDetailModifyState extends State<ForumCrewPostDetailModify> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.specificPost.title);
    contentController = TextEditingController(text: widget.specificPost.content);
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 수정하기'),
        backgroundColor: Colors.green,
      ),
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Original Title: ${widget.specificPost.title}', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Original Content: ${widget.specificPost.content}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'New Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'New Content'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
              // Call the updatePost method in the provider
              await Provider.of<ForumCrewPostProvider>(context, listen: false)
              .updatePost(widget.specificPost.documentnum, titleController.text, contentController.text);
              // Pop the current screen
              Navigator.pop(context);
                },
              child: Text('수정 완료하기'),
            ),
          ],
        ),
      ),
    );
  }
}