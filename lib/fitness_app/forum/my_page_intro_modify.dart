import 'package:flutter/material.dart';
import 'widgets/image_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'my_page.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '../providers/user_mypage_provider.dart';

class ProfileIntroPage extends StatelessWidget {

  final String id; 
  final String intro;
  
  ProfileIntroPage({required this.id,required this.intro});
  TextEditingController introController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('소개글 변경하기'),
        backgroundColor: Colors.green,
      ),
      body: 
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
      Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [       
       TextField(
                  controller: introController,
                  decoration: InputDecoration(
                    hintText: '$intro',
                  ),
                ),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: () async {
        // Handle intro update
        String newIntro = introController.text;
        await Provider.of<UserProvider>(context, listen: false)
        .updateIntro(id, newIntro);
        showCompleteMessage();
        Future.delayed(Duration(milliseconds: 300), () {
        Navigator.pop(context);
              
        });
        },
        child: Text('소개글 작성하기'),
              ),
          ],
        ),
      ),
    );
  }
}
    
    


void showCompleteMessage(){
  Fluttertoast.showToast(
    msg: '소개글 변경 완료',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}

