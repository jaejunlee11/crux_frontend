
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
