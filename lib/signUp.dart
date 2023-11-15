import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  String hashPassword(String password) {
    final bytes = utf8.encode(password); // 비밀번호를 바이트 배열로 변환
    final digest = sha256.convert(bytes); // SHA-256 해싱 수행

    return digest.toString();
  }

  Future<void> _registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      // Passwords do not match, show a warning popup
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('비밀번호 확인'),
            content: const Text('비밀번호가 일치하지 않습니다.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      final url =
          Uri.parse('http://0.0.0.0:8000/post-user'); // Django API 엔드포인트
      final response = await http.post(
        url,
        body: {
          'memberid': usernameController.text,
          'memberpw': hashPassword(passwordController.text),
          'membernickname': nicknameController.text,
        },
      );

      if (response.statusCode == 201) {
        // 회원가입이 성공한 경우
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('회원가입 완료'),
              content: const Text('회원가입이 완료되었습니다.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context)
                        .pop(); // Close the sign-up screen and go back
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      } else {
        // 회원가입이 실패한 경우
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('회원가입 실패'),
              content: const Text('이미 존재하는 아이디 입니다.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
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
      appBar: AppBar(
        title: const Text('회원가입'),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: '사용자 이름',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                    labelText: '닉네임',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
