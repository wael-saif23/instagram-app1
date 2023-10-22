import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_s_m_app/share/colors.dart';
import 'package:intl/intl.dart';

import '../screens/comments.dart';

class UsersPostsContainer extends StatefulWidget {
  const UsersPostsContainer({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  State<UsersPostsContainer> createState() => _UsersPostsContainerState();
}

class _UsersPostsContainerState extends State<UsersPostsContainer> {
  int commentCount = 0;

  getcommentCount() async {
    try {
      QuerySnapshot commentsData = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.data["postId"])
          .collection("comments")
          .get();

      setState(() {
        commentCount = commentsData.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
  }

// to delet the post
  showmodel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            FirebaseAuth.instance.currentUser!.uid == widget.data["uid"]
                ? SimpleDialogOption(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await FirebaseFirestore.instance
                          .collection("posts")
                          .doc(widget.data["postId"])
                          .delete();
                    },
                    padding: const EdgeInsets.all(22),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          "Delete the post!",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  )
                : const SimpleDialogOption(
                    padding: EdgeInsets.all(22),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          "you cannot delete this post",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              padding: const EdgeInsets.all(22),
              child: const Row(
                children: [
                  Icon(
                    Icons.photo_album,
                    size: 30,
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Text(
                    "cancel",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcommentCount();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: mobileBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
          vertical: 11, horizontal: widthScreen > 600 ? widthScreen / 6 : 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(
                          widget.data["profileImg"],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    Text(
                      widget.data["username"],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      showmodel();
                    },
                    icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
          Image.network(
            widget.data["imgPost"],
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                    showtextfield: true,
                                    userData: widget.data,
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.comment_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_outline),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: double.infinity,
              child: Text(
                "${widget.data["likes"].length}  ${widget.data["likes"].length > 1 ? "Likes" : "like"} ",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
              )),
          Row(
            children: [
              const SizedBox(
                width: 9,
              ),
              Text(
                // "${widget.snap["username"]}",
                widget.data["username"],
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 189, 196, 199)),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                // " ${widget.snap["description"]}",
                widget.data["description"],
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 189, 196, 199)),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                          showtextfield: false,
                          userData: widget.data,
                        )),
              );
            },
            child: Container(
                margin: const EdgeInsets.fromLTRB(10, 13, 9, 10),
                width: double.infinity,
                child: Text(
                  "view all $commentCount comments",
                  style: const TextStyle(
                      fontSize: 18, color: Color.fromARGB(212, 73, 139, 240)),
                  textAlign: TextAlign.start,
                )),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
              width: double.infinity,
              child: Text(
                DateFormat('MMMM ,d,y')
                    .format(widget.data["datePublished"].toDate()),
                // widget.data["datePublished"],
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                textAlign: TextAlign.start,
              )),
        ],
      ),
    );
  }
}
