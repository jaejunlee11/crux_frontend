
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

  factory User.initial() {
    return User(
      ID: '',
      PW: '',
      nickname: '',
      profilepic: '',
      intro: '',
      recentqueue: '',
    );
  }



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
      ID : json['memberid'] ?? '',
      PW : json['memberpw'] ?? '',
      nickname : json['membernickname'] ?? '',
      profilepic : json['memberprofilepic'] ?? '',
      intro : json['memberprofileintro'] ?? '',
      recentqueue : json ['memberprofilerecentqueue'] ?? '',
    );
  }
  static List<User> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  static List<dynamic> listToJson(List<User> users) {
    return users.map((user) => user.toJson()).toList();
  }


   Map<String, dynamic> toJson() => {
      'memberid': ID,
      'memberpw': PW,
      'membernickname':nickname,
      'memberprofilepic':profilepic,
      'memberprofileintro':intro,
      'memberProfilerecentqueue':recentqueue,
  };

}
