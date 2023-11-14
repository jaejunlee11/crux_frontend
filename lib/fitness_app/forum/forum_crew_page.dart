import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/forum_crew_post_list_data.dart';
import 'package:provider/provider.dart';
import '../providers/forum_crew_post_list_provider.dart';
import 'forum_crew_post_home.dart';
import 'forum_new_post_page.dart';

// 민재 : 크루 모집 게시판 화면 구현 -> 해당 화면에 필요현 list_view, model도 구현

class CrewForumApp extends StatelessWidget {
  const CrewForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForumCrewPostProvider(),
      child: MaterialApp(
        title: '자유 게시판(전체보기)',
        home: ForumCrewHomeScreen(),
      ),
    );
  }
}
