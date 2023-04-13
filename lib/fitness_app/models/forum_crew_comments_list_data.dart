class CrewForumCommentListData {
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
