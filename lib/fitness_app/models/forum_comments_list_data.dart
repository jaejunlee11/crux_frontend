// class Comment {
//   final int replynum;
//   final int documentnum;
//   final String username;
//   final String writedate;
//   final String content;

//   Comment(
//       {
//       required this.replynum,
//       required this.documentnum,
//       required this.username,
//       required this.writedate,
//       required this.content});

//   Comment.fromMap(Map<String, dynamic>map)
//     : replynum = map['ReplyID'],
//       documentnum = map['OriginPostID'],
//       username = map['WritterID'],
//       writedate = map['ReplyDate'],
//       content = map['ReplyContent'];

//   Comment.fromJson(Map<String, dynamic> json)
//     : replynum = json['ReplyID'],
//       documentnum = json['OriginPostID'],
//       username = json['WritterID'],
//       writedate = json['ReplyDate'],
//       content = json['ReplyContent'];
// }

// List<Comment> comments = [];
// bool isLoading = false;

//M:기존 UI용 리스트 데이터
/*class ForumCommentListData {
 static List<Comment> forumComments = [
    Comment(documentnum: 1, username: "User1", content: "Comment 1"),
    Comment(documentnum: 1, username: "User2", content: "Comment 2"),
    Comment(documentnum: 2, username: "User3", content: "Comment 1"),
    Comment(documentnum: 2, username: "User4", content: "Comment 2"),
  ];
  */
//api 통신을 위해 변경해본 테스트 코드(차후 삭제 요망)
/*

    static List<Comment> forumComments = [];
    
    static void loadCommentsFromJsonFile(String filePath) {
    final file = File(filePath);
    final jsonString = file.readAsStringSync();
    final jsonData = json.decode(jsonString);

    if (jsonData is List) {
      forumComments = jsonData.map((commentData) {
        return Comment(
          documentnum: commentData['documentnum'],
          username: commentData['username'],
          content: commentData['content'],
        );
      }).toList();
    }
  }
}
*/
class ForumCommentListData {
  static List<Comment> forumComments = [
    Comment(documentnum: 1, username: "User1", content: "Comment 1"),
    Comment(documentnum: 1, username: "User2", content: "Comment 2"),
    Comment(documentnum: 2, username: "User3", content: "Comment 1"),
    Comment(documentnum: 2, username: "User4", content: "Comment 2"),
  ];
}

class Comment {
  final int documentnum;
  final String username;
  final String content;

  Comment(
      {required this.documentnum,
      required this.username,
      required this.content});
}
