
class ForumCrewPost {
  int documentnum;
  String title;
  String content; 
  String username;
  String postdate;
  String region;
  int like;
  int dislike;

  ForumCrewPost(
      {required this.documentnum,
      required this.title,
      required this.content,
      required this.username,
      required this.region,
      required this.postdate,
      required this.like,
      required this.dislike
      });

  factory ForumCrewPost.fromJson(Map<String, dynamic> json){
    return ForumCrewPost(
      documentnum : json['postsid'],
      title : json['posttitle'],
      content : json['postcontent'],
      username : json['postwritememid'],
      region : json['region'],
      postdate : json['writedate'], 
      like : json ['likenum'],
      dislike : json ['dislikenum']
    );
  }

    ForumCrewPost copyWith({
    int? documentnum,
    String? title,
    String? content, 
    String? username,
    String? postdate,
    int? like,
    int? dislike,
    String? region,
  }) {
    return ForumCrewPost(
      documentnum: documentnum ?? this.documentnum,
      title: title ?? this.title,
      content: content ?? this.content,
      username: username ?? this.username,
      postdate: postdate ?? this.postdate,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
      region: region?? this.region,
    );
  }


  dynamic toJson() => {
      'postsid': documentnum,
      'posttitle': title,
      'postcontent':content,
      'postwritememid':username,
      'region':region,
      'writedate':postdate,
      'likenum':like,
      'dislikenum':dislike
  };


}
