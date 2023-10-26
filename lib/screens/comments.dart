// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_s_m_app/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../firebase_servises/firestore.dart';
import '../share/colors.dart';
import '../share/contants.dart';

class CommentsScreen extends StatefulWidget {
  final Map userData;
  final bool showtextfield;
  const CommentsScreen(
      {Key? key, required this.userData, required this.showtextfield})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentController = TextEditingController();
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Comments',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.userData["postId"])
                .collection("comments")
                .orderBy("dataPublished")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: Colors.white,
                );
              }

              return Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(125, 78, 91, 110),
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(data["profilePic"]),
                                  radius: 26,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(data["username"],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17)),
                                      SizedBox(
                                        width: 11,
                                      ),
                                      Text(data["textComment"],
                                          style: const TextStyle(fontSize: 16))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      DateFormat('MMMM ,d,y').format(
                                          data["dataPublished"].toDate()),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
          widget.showtextfield
              ? Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110),
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userData!.imgUrl),
                          radius: 26,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                            controller: commentController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: decorationTextfield.copyWith(
                                hintText: "Comment as  ${userData.username} ",
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      FirestoreMethods().uploadComments(
                                          postId: widget.userData["postId"],
                                          profilePic: userData.imgUrl,
                                          username: userData.username,
                                          textComment: commentController.text,
                                          uid: userData.uid,
                                          context: context);

                                      commentController.clear();
                                    },
                                    icon: Icon(Icons.send)))),
                      ),
                    ],
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
