
class User {
  String ID;
  String PW;
  String nickname; 
  String profilepic;
  String intro;
  String recentqueue;

  User(
      {required this.ID,
      required this.PW,
      required this.nickname,
      required this.profilepic,
      required this.intro,
      required this.recentqueue,
      });

  User copyWith({
    String? ID,
    String? PW,
    String? nickname, 
    String? profilepic,
    String? intro,
    String? recentqueue,
  }) {
    return User(
      ID: ID ?? this.ID,
      PW: PW ?? this.PW,
      nickname: nickname ?? this.nickname,
      profilepic: profilepic ?? this.profilepic,
      intro: intro ?? this.intro,
      recentqueue: recentqueue ?? this.recentqueue,

    );
  }

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      ID : json['MemberID'],
      PW : json['MemberPW'],
      nickname : json['MemberNickname'],
      profilepic : json['MemberProfilePic'],
      intro : json['MemberProfileIntro'], 
      recentqueue : json ['MemberProfileRecentQueue'],
    );
  }
  static List<User> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  static List<dynamic> listToJson(List<User> users) {
    return users.map((user) => user.toJson()).toList();
  }


   Map<String, dynamic> toJson() => {
      'MemberID': ID,
      'MemberPW': PW,
      'MemberNickname':nickname,
      'MemberProfilePic':profilepic,
      'MemberProfileIntro':intro,
      'MemberProfileRecentQueue':recentqueue,
  };

}
