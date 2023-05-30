import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_s_m_app/share/snackbar.dart';


class AuthMethods {
  register({required emailll, required passworddd, required context}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }
  }
}