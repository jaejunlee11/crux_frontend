import 'package:best_flutter_ui_templates/fitness_app/forum/my_page_profile_select.dart';
import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';

// 민재 : 마이페이지 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현
class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.userId, required this.userNickname});
  final String userId;
  final String userNickname;
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final int _level = 1;
  final int _exp = 0;
  String _userid = '';
  String _nickname = '';
  final String _introtext = '안녕하세요';
  AssetImage profileImage = const AssetImage('assets/images/userImage.png');
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _userid = widget.userId;
    _nickname = widget.userNickname;
    // Other initialization if needed
  }

  _MyPageState();

//CalendarController _calendarController = CalendarController();
//Map<DateTime, List<dynamic>> _events = {};
//List<dynamic> _selectedEvents = [];

  void _calculateprogress() {
    setState(() {
      _progress = _exp / (_level * 100);
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
            backgroundImage: profileImage,
          ),
          const SizedBox(height: 16),
          Text(
            '내 닉네임: $_nickname',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            '내 ID: $_userid',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(
            '내 소개글: $_introtext',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '내 레벨 $_level',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$_exp / ${_level * 100}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileSelectPage()),
              );
            },
            child: const Text('프로필 이미지 선택하기'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            onPressed: () {},
            child: const Text('소개글 변경하기'),
          )
        ],
      ),
    );
  }
}
