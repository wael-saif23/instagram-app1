import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_s_m_app/share/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userData = {};
  bool isloading = true;
  int following = 0;
  int followers = 0;
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

      followers = userData["followers"].length;
      following = userData["following"].length;
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }

  
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return isloading
        ? Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .1,
                height: MediaQuery.of(context).size.width * .1,
                child: const CircularProgressIndicator(
                  color: Color.fromARGB(255, 118, 118, 118),
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(userData["username"]),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 22),
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            // widget.snap["profileImg"],
                            userData["imgUrl"]),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: const [
                              Text(
                                "1",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Column(
                            children: [
                              Text(
                                followers.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Column(
                            children: [
                              Text(
                                following.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Following",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(15, 21, 0, 0),
                    width: double.infinity,
                    child: Text(userData["tilte"])),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.white,
                  thickness: widthScreen > 600 ? 0.06 : 0.44,
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                      label: const Text(
                        "Edit profile",
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(0, 90, 103, 223)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: widthScreen > 600 ? 19 : 10,
                            horizontal: 33)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side: const BorderSide(
                                color: Color.fromARGB(109, 255, 255, 255),
                                // width: 1,
                                style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.logout,
                        size: 24.0,
                      ),
                      label: const Text(
                        "Log out",
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(143, 255, 55, 112)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: widthScreen > 600 ? 19 : 10,
                            horizontal: 33)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                Divider(
                  color: Colors.white,
                  thickness: widthScreen > 600 ? 0.06 : 0.44,
                ),
                const SizedBox(
                  height: 19,
                ),
                Expanded(
                  child: Padding(
                    padding: widthScreen > 600
                        ? const EdgeInsets.all(66.0)
                        : const EdgeInsets.all(3.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              "https://cdn1-m.alittihad.ae/store/archive/image/2021/10/22/6266a092-72dd-4a2f-82a4-d22ed9d2cc59.jpg?width=1300",
                              // height: 333,
                              // width: 100,

                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
  }
}
