import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_s_m_app/firebase_servises/storage.dart';
import 'package:insta_s_m_app/models/user.dart';
import 'package:insta_s_m_app/share/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  register(
      {required emailll,
      required passworddd,
      required context,
      required tilte,
      required username,
      required imgName,
       required imgPath,
       
      
      }) async {
    String message = "ERROR => Not starting the code";

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );
      message = "ERROR => Registered only";

      String imgUrl =await getImgURL(imgName: imgName, imgPath: imgPath);

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      UserModel userdata = UserModel(
          emailll: emailll,
          tilte: tilte,
          passworddd: passworddd,
          username: username,
          imgUrl: imgUrl,
          uid: credential.user!.uid,
          followers: [],
          following: [],

          
          
          );

      users
          .doc(credential.user!.uid)
          .set(userdata.convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      message = " Registered & User Added 2 DB ♥";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }





    signIn({required emailll,required passworddd, required context}) async {
   

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailll, password: passworddd);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }

    
  }



  Future<UserModel> getUserDetails() async {
   DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(); 
   return UserModel.convertSnap2Model(snap);
 }

}
