//기존의 comment 저장 방식은 제외하는 방향으로 forumpost만 불러오도록

class ForumPost {
  int documentnum;
  String title;
  String content; 
  String username;
  String postdate;

  ForumPost(
      {required this.documentnum,
      required this.title,
      required this.content,
      required this.username,
      required this.postdate,
      });
/*
  ForumPost.fromMap(Map<String, dynamic>map)
    : documentnum = map['postsid'],
      title = map['posttitle'],
      content = map['postcontent'],
      username = map['postwritememid'],
      postdate = map['writedate'];
*/
  factory ForumPost.fromJson(Map<String, dynamic> json){
    return ForumPost(
      documentnum : json['postsid'],
      title : json['posttitle'],
      content : json['postcontent'],
      username : json['postwritememid'],
      postdate : json['writedate']
    );
  }
  dynamic toJson() => {
      'postsid': documentnum,
      'posttitle': title,
      'postcontent':content,
      'postwritememid':username,
      'writedate':postdate
  };


}
/*
List<ForumPost> posts = [];
bool isLoading = false;
*/



//M:기존 UI 구현을 위해 작성했던 코드(차후 삭제 요망)
/*
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
*/