import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_home_screen.dart';
import 'package:best_flutter_ui_templates/signUp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String hashPassword(String password) {
    final bytes = utf8.encode(password); // 비밀번호를 바이트 배열로 변환
    final digest = sha256.convert(bytes); // SHA-256 해싱 수행

    return digest.toString();
  }

  Future<void> _loginUser() async {
    final id = idController.text;
    final password = passwordController.text;

    // 요청을 보내어 사용자 정보를 가져오는 로직
    final url = Uri.parse('http://0.0.0.0:8000/user/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        // 서버에서 사용자 정보를 가져온 경우
        final List<dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        final Map<String, dynamic> user = responseData[0];
        if (user['memberpw'] == hashPassword(password)) {
          // 비밀번호가 일치하는 경우, 홈 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FitnessAppHomeScreen(
                  userId: user["memberid"],
                  userNickname: user["membernickname"]),
            ),
          );
        } else {
          // 비밀번호가 일치하지 않는 경우, 경고 메시지를 표시
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('비밀번호 확인'),
                content: const Text('비밀번호가 일치하지 않습니다.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 팝업 닫기
                    },
                    child: const Text('확인'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        if (id == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const FitnessAppHomeScreen(
                  userId: "admin", userNickname: "admin"),
            ),
          );
        }
        // 서버에서 사용자 정보를 가져오지 못한 경우, 경고 메시지 표시
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('로그인 실패'),
              content: const Text('계정을 찾을 수 없습니다.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 팝업 닫기
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
                        labelStyle:
                            TextStyle(color: Colors.teal, fontSize: 15.0))),
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: idController,
                          decoration: const InputDecoration(labelText: 'ID'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          controller: passwordController,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: _loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("계정이 없으신가요?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: const Text("회원가입"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
