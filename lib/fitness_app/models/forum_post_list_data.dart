import 'forum_comments_list_data.dart';

class ForumPost {
  final int documentnum;
  final String title;
  final String content;
  final Map<Comment,dynamic> comments;

  ForumPost(
      {required this.title,
      required this.content,
      required this.comments,
      required this.documentnum});
}

class ForumPostListData {
  static List<ForumPost> forumPosts = [
    ForumPost(
      documentnum: 1,
      title: "글 1",
      content: "본문 1",
      comments: ForumCommentListData.forumComments
        .where((comment) => comment.documentnum == 1)
        .toList(),
      ),
    ForumPost(
      documentnum: 2,
      title: "Post 2",
      content: "This is the content for post 2",
      comments: [
        ...ForumCommentListData.forumComments.map(
          (comment) => Comment(
            documentnum: comment.documentnum,
            username: comment.username,
            content: comment.content,
          ),
        ),
      ],
    ),
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
