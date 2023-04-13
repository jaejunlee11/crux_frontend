import 'forum_crew_comments_list_data.dart';

class CrewForumPost {
  final int documentnum;
  final String title;
  final String content;
  final String region;
  final List<Comment> comments;

  CrewForumPost(
      {required this.title,
      required this.content,
      required this.region,
      required this.comments,
      required this.documentnum});
}

class CrewForumPostListData {
  static List<CrewForumPost> forumPosts = [
    CrewForumPost(
      documentnum: 1,
      title: "글 1",
      content: "본문 1",
      region: 'seoul',
      comments: [
        ...CrewForumCommentListData.forumComments.map(
          (comment) => Comment(
            documentnum: comment.documentnum,
            username: comment.username,
            content: comment.content,
          ),
        ),
      ],
    ),
    CrewForumPost(
      documentnum: 2,
      title: "Post 2",
      content: "This is the content for post 2",
      region: 'Gyeonggi',
      comments: [
        ...CrewForumCommentListData.forumComments.map(
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
