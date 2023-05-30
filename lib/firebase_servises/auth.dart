import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_s_m_app/share/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  register(
      {required emailll,
      required passworddd,
      required context,
      required tilte,
      required username}) async {
    String message = "ERROR => Not starting the code";

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );
      message = "ERROR => Registered only";

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users
          .doc(credential.user!.uid)
          .set({
            'Password': passworddd,
            'Email': emailll,
            'title': tilte,
            'username': username
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      message = " Registered & User Added 2 DB ♥";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }
  }
}
