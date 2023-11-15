//기존의 comment 저장 방식은 제외하는 방향으로 forumpost만 불러오도록

class ForumPost {
  int documentnum;
  String title;
  String content; 
  String username;
  String postdate;
  int like;
  int dislike;

  ForumPost(
      {required this.documentnum,
      required this.title,
      required this.content,
      required this.username,
      required this.postdate,
      required this.like,
      required this.dislike
      });

  ForumPost copyWith({
    int? documentnum,
    String? title,
    String? content, 
    String? username,
    String? postdate,
    int? like,
    int? dislike,
  }) {
    return ForumPost(
      documentnum: documentnum ?? this.documentnum,
      title: title ?? this.title,
      content: content ?? this.content,
      username: username ?? this.username,
      postdate: postdate ?? this.postdate,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
    );
  }

  factory ForumPost.fromJson(Map<String, dynamic> json){
    return ForumPost(
      documentnum : json['postsid'],
      title : json['posttitle'],
      content : json['postcontent'],
      username : json['postwritememid'],
      postdate : json['writedate'], 
      like : json ['likenum'],
      dislike : json ['dislikenum']
    );
  }
  dynamic toJson() => {
      'postsid': documentnum,
      'posttitle': title,
      'postcontent':content,
      'postwritememid':username,
      'writedate':postdate,
      'likenum':like,
      'dislikenum':dislike
  };

void pluslike(){
  like++;
}

void plusdislike(){
  dislike++;
}



}
