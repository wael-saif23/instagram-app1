import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_s_m_app/firebase_servises/storage.dart';
import 'package:insta_s_m_app/models/posts.dart';
import 'package:insta_s_m_app/models/user.dart';
import 'package:insta_s_m_app/share/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  uploadPost(
      {required imgName,
      required imgPath,
      required description,
      required profileImg,
      required username,
      required context}) async {
    String message = "ERROR => Not starting the code";

    try {
      String postId = const Uuid().v1();

      String imgUrl = await getImgURL(
          imgName: imgName,
          imgPath: imgPath,
          folderName: 'imagePosts/${FirebaseAuth.instance.currentUser!.uid}');

      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');

      PostsModel postsdata = PostsModel(
          datePublished: DateTime.now(),
          description: description,
          imgPost: imgUrl,
          likes: [],
          profileImg: profileImg,
          postId: postId,
          uid: FirebaseAuth.instance.currentUser!.uid,
          username: username);

      message = "ERROR => erroe hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";

      posts
          .doc(postId)
          .set(postsdata.convert2Map())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to post: $error"));

      message = " Posted successfully ♥ ♥";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }
}
