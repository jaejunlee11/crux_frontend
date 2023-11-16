import 'package:flutter/material.dart';
import 'widgets/image_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'my_page.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '../providers/user_mypage_provider.dart';

class ProfileSelectPage extends StatelessWidget {

 final User user;
  
  ProfileSelectPage({required this.user});


  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 변경하기'),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: ImageList.images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              print('눌렸음');
              // Handle image tap
              String selectedImage = ImageList.images[index].assetName;
              await userProvider.updateProfilePic(user, selectedImage);
              showCompleteMessage(); 

              Future.delayed(Duration(milliseconds: 300),(){
             Navigator.pop(
                context
             );
              });
            },
            child: Card(
              elevation: 2.0,
              child:  Image(image: ImageList.images[index]),            
            ),
          );
        },
      )
    );
  }
}

void showCompleteMessage(){
  Fluttertoast.showToast(
    msg: '프로필 변경 완료',
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );
}
