import 'package:flutter/material.dart';
//import 'package:table_calendar/table_calendar.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _level = 1;
  int _exp = 0;
  final String _nickname = 'John Doe';
  final AssetImage _profileImage =
      const AssetImage('assets/images/userImage.png');

//CalendarController _calendarController = CalendarController();
//Map<DateTime, List<dynamic>> _events = {};
//List<dynamic> _selectedEvents = [];

  void _increaseExp() {
    setState(() {
      _exp += 10;
      if (_exp >= 100) {
        _exp = 0;
        _level++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _profileImage,
          ),
          const SizedBox(height: 16),
          Text(
            _nickname,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Level $_level',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: LinearProgressIndicator(
                  value: _exp / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$_exp/100 XP',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Degug: Gain XP'),
            onPressed: () {
              _increaseExp();
            },
          ),
        ],
      ),
    );
  }
}
