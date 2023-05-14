//M:api 연동 작업을 위해 추가한 파일(차후 수정 가능성)

import 'dart:convert';
import 'forum_comments_list_data.dart';
import 'forum_post_list_data.dart';

List<Comment> parseComment(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.List<Comment>((json) => Comment.fromJson(json)).toList();
}

List<ForumPost> parseForumPost(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.List<ForumPost>((json) => ForumPost.fromJson(json)).toList();
}

