import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_s_m_app/screens/add_post.dart';
import 'package:insta_s_m_app/screens/home.dart';
import 'package:insta_s_m_app/screens/profile.dart';
import 'package:insta_s_m_app/screens/search.dart';
import 'package:insta_s_m_app/share/colors.dart';

class MopileScreen extends StatefulWidget {
  const MopileScreen({super.key});

  @override
  State<MopileScreen> createState() => _MopileScreenState();
}

class _MopileScreenState extends State<MopileScreen> {
  final PageController _pageController = PageController();
  int selectedScreen = 0;
  double primaryIconSize = 32;
  double secondaryIconSizr = 24;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: CupertinoTabBar(
          onTap: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              selectedScreen = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
              Icons.home,
              color: selectedScreen == 0 ? primaryColor : secondaryColor,
              size: selectedScreen == 0? primaryIconSize :secondaryIconSizr,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.search,
              color: selectedScreen == 1 ? primaryColor : secondaryColor,
              size: selectedScreen == 1? primaryIconSize :secondaryIconSizr,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.add_circle,
              color: selectedScreen == 2 ? primaryColor : secondaryColor,
              size: selectedScreen == 2? primaryIconSize :secondaryIconSizr,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.favorite,
              color: selectedScreen == 3 ? primaryColor : secondaryColor,
              size: selectedScreen == 3? primaryIconSize :secondaryIconSizr,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.person,
              color: selectedScreen == 4 ? primaryColor : secondaryColor,
              size: selectedScreen == 4? primaryIconSize :secondaryIconSizr,
            )),
          ]),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {},
        physics: const NeverScrollableScrollPhysics(),
        children:  [
          const Home(),
          const Search(),
          const AddPost(),
          const Center(child: Text("My favorite")),
          Profile(userUid: FirebaseAuth.instance.currentUser!.uid,),
        ],
      ),
    );
  }
}
