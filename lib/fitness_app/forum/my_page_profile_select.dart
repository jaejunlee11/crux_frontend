import 'package:flutter/material.dart';
import 'widgets/image_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'my_page.dart';


class ProfileSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 이미지 선택'),
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
            onTap: () {
              // Handle image tap
              print('Image tapped: ${ImageList.images[index].assetName}');
              showCompleteMessage(); 
              Future.delayed(Duration(milliseconds: 300),(){
             Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPage()),
             );
              });
            },
            child: Card(
              elevation: 2.0,
              child: Image(image: ImageList.images[index]),
            ),
          );
        },
      ),
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

