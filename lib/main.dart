import 'package:best_flutter_ui_templates/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fitness_app/providers/user_mypage_provider.dart';
import 'fitness_app/providers/forum_post_list_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
    runApp(
      MultiProvider(
        providers: [
           ChangeNotifierProvider(create: (context) => UserProvider()),
           ChangeNotifierProvider(create: (context) => ForumPostProvider()),         
        ],
        child: MyApp(),
      ),
  );
}





//original :   runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LogIn(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
