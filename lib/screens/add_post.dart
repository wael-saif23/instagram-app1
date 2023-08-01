import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_s_m_app/share/colors.dart';
import 'package:path/path.dart' show basename;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? imgPath;
  String? imgName;
  bool isPosted = true;
  Map userData = {};
  bool isloading = true;

  getdata() async {
    try {
      setState(() {
        isloading = true;
      });
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;

      setState(() {
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  showmodel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                await uploadImage2Screen(ImageSource.camera);
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
                    "From Camera",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                uploadImage2Screen(ImageSource.gallery);
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
                    "From Gallery",
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
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return imgPath == null
        ? Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: Center(
              child: IconButton(
                  onPressed: () {
                    showmodel();
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 55,
                  )),
            ),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        isPosted = false;
                        imgPath = null;
                      });
                    },
                    child: const Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    )),
              ],
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      imgPath = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Column(
              children: [
                isPosted
                    ? const Divider(
                        thickness: 1,
                        height: 30,
                      )
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: secondaryColor,
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: NetworkImage(userData["imgUrl"] ?? ""),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: const TextField(
                        // controller: descriptionController,
                        maxLines: 8,
                        decoration: InputDecoration(
                            hintText: "write a caption...",
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                        width: 66,
                        height: 74,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: MemoryImage(imgPath!),
                                fit: BoxFit.cover))),
                  ],
                ),
              ],
            ),
          );
  }
}
