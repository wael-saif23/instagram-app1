class UserModel {
  String username;
  String tilte;
  String emailll;
  String passworddd;
  String imgUrl;
  String uid;
  List following;
  List followers;

  UserModel({
    required this.emailll,
    required this.tilte,
    required this.passworddd,
    required this.username,
    required this.imgUrl,
    required this.uid,
    required this.followers,
    required this.following
  });

  Map<String, dynamic> convert2Map() {
    return {
      "username": username,
      "tilte": tilte,
      "emailll": emailll,
      "passworddd": passworddd,
      "imgUrl": imgUrl,
      "uid": uid,
      "followers":[],
      "following":[],
    };
  }
}
