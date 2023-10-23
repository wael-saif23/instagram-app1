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

  uploadComments(
      {required postId,
      required profilePic,
      required username,
      required textComment,
      required uid,
      required context}) async {
    String message = "ERROR => Not starting the code";

    try {
      if (textComment.isNotEmpty) {
        String commentId = const Uuid().v1();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "profilePic": profilePic,
          "username": username,
          "textComment": textComment,
          "dataPublished": DateTime.now(),
          "uid": uid,
          "commentId": commentId,
        });
        message = " your Commend successfully posted ♥ ♥";
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }

  likes({required Map data}) async {
    try {
      if (data["likes"].contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(data["postId"])
            .update({
          "likes":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(data["postId"])
            .update({
          "likes":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
