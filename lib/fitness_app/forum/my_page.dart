import 'package:best_flutter_ui_templates/fitness_app/forum/my_page_profile_select.dart';
import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';
import '../providers/user_mypage_provider.dart';
import '../models/user.dart';
import 'my_page_intro_modify.dart';

// 민재 : 마이페이지 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.userId, required this.userNickname});
  final String userId;
  final String userNickname;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late int level = 1;
  final String _introtext = '안녕하세요';
  AssetImage profileImage = const AssetImage('assets/images/userImage.png');
  double _progress = 0;
  late int nowlevelexp;
  late User _user;
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    _user = User.initial();
    _fetchUserInfo();
    // Other initialization if needed
  }

  Future<void> _fetchUserInfo() async {
    User? user = await _userProvider.fetchUserInfo(widget.userId);
    if (user != null) {
      print("Fetched user info: ${user.nickname}");
      setState(() {
        _user = user;
      });
      _calculatelevel();
      _calculateprogress();
    } else {
      print("Failed to get user info");
    }
  }

  void _calculateprogress() {
    setState(() {
      _progress = (nowlevelexp) / (level * 100);
    });
  }

  void _calculatelevel() {
    setState(() {
      int tempexp = _user.recentqueue;
      int templevel = 1;
      int temprequiredexp = 100;
      while (tempexp > temprequiredexp) {
        tempexp = tempexp - temprequiredexp;
        temprequiredexp = temprequiredexp + 100;
        templevel++;
      }
      ;
      level = templevel;
      nowlevelexp = tempexp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('내 정보'),
          backgroundColor: Colors.green,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(_user.profilepic),
            ),
            const SizedBox(height: 16),
            Text(
              '내 닉네임: ${_user.nickname}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '내 ID: ${_user.ID}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              '내 소개글: ${_user.intro}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '내 레벨 $level',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${nowlevelexp} / ${level * 100}',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                var updatedUser = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSelectPage(user: _user),
                  ),
                );
                _fetchUserInfo();
              },
              child: const Text('프로필 이미지 선택하기'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileIntroPage(id: _user.ID, intro: _user.intro)),
                );
                _fetchUserInfo();
              },
              child: const Text('소개글 변경하기'),
            )
          ],
        ));
  }
}
