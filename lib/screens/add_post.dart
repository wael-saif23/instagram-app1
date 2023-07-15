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
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: const [
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
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.photo_outlined,
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isPosted? Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {},
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
                  onPressed: () {}, icon: const Icon(Icons.arrow_back)),
            ),
            body: Column(
              children: [
                const Divider(
                  thickness: 1,
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CircleAvatar(
                      radius: 33,
                      backgroundImage: NetworkImage(
                          userData["imgUrl"]),
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
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                        "https://cdn1-m.alittihad.ae/store/archive/image/2021/10/22/6266a092-72dd-4a2f-82a4-d22ed9d2cc59.jpg?width=1300",
                      )

                              // image: MemoryImage(imgPath!), fit: BoxFit.cover
                              //
                              //
                              )),
                    )
                  ],
                ),
              ],
            ),
    ) : Scaffold(
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
    );
  }
}
