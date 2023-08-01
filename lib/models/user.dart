import 'package:cloud_firestore/cloud_firestore.dart';

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

   static    convertSnap2Model(DocumentSnapshot snap) {
 var snapshot = snap.data() as Map<String, dynamic>;
 return UserModel(
  username: snapshot["username"],
  tilte: snapshot["tilte"],
  emailll: snapshot["emailll"],
  passworddd: snapshot["passworddd"],
  imgUrl: snapshot["imgUrl"],
  uid: snapshot["uid"],
  followers: snapshot["followers"],
  following: snapshot["following"],
  

  );
 }
}
