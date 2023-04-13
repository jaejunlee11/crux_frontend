import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';

// 재준 : 로그인 화면 구현
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 150)),
          const Center(
            child: Image(
              image: AssetImage('assets/images/climbing.png'),
              width: 170.0,
            ),
          ),
          Form(
              child: Theme(
            data: ThemeData(
                primaryColor: Colors.grey,
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0))),
            child: Container(
                padding: const EdgeInsets.all(40.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(labelText: 'ID'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        keyboardType: TextInputType.text,
                        obscureText: true, // 비밀번호 안보이도록 하는 것
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FitnessAppHomeScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ))
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
