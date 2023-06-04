class UserModel {
  String username;
  String tilte;
  String emailll;
  String passworddd;

  UserModel(
      {required this.emailll,
      required this.tilte,
      required this.passworddd,
      required this.username});


      Map<String, dynamic> convert2Map() {
  return {"username": username,
  "tilte": tilte,
  "emailll": emailll,
  "passworddd": passworddd,

  
  };
 }
}
