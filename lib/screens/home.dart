import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:insta_s_m_app/share/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:widthScreen>600?webBackgroundColor: mobileBackgroundColor,
      appBar:widthScreen>600?null: AppBar(
        actions: [
          IconButton(
              onPressed: () {
               
              },
              icon: const Icon(
                Icons.messenger_outline,
              )),
          IconButton(
              onPressed: () async{
                 await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
              )),
        ],
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          "assets/img/instagram.svg",
           color: primaryColor,
          height: 32,
        ),
      ),
      body: Center(
        child: Container(
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
                      children: const [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 36,
                            backgroundImage: NetworkImage(
                                // widget.snap["profileImg"],
                                "https://i.pinimg.com/564x/d8/c5/6a/d8c56a664bc9a28d7e32b01a71884af2.jpg"),
                          ),
                        ),
                        SizedBox(
                          width: 17,
                        ),
                        Text(
                          // widget.snap["username"],
                          "Layla hassan",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  ],
                ),
              ),
              Image.network(
                // widget.snap["postUrl"],
                "https://i.pinimg.com/564x/a2/9a/94/a29a94a8aee1a11bd5aa1a5d5d9d670c.jpg",
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
                          onPressed: () {},
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
                  child: const Text(
                    "10 Likes",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                  )),
              Row(
                children: [
                  const SizedBox(
                    width: 9,
                  ),
                  const Text(
                    // "${widget.snap["username"]}",
                    "USERNAME ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 189, 196, 199)),
                  ),
                  const Text(
                    // " ${widget.snap["description"]}",
                    " Sidi Bou Said ♥",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 189, 196, 199)),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 13, 9, 10),
                    width: double.infinity,
                    child: const Text(
                      "view all 100 comments",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                      textAlign: TextAlign.start,
                    )),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
                  width: double.infinity,
                  child: const Text(
                    "10June 2022",
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                    textAlign: TextAlign.start,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
