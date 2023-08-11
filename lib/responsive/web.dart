import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_s_m_app/screens/add_post.dart';
import 'package:insta_s_m_app/screens/home.dart';
import 'package:insta_s_m_app/screens/profile.dart';
import 'package:insta_s_m_app/screens/search.dart';
import 'package:insta_s_m_app/share/colors.dart';

class WebScerren extends StatefulWidget {
  const WebScerren({Key? key}) : super(key: key);

  @override
  State<WebScerren> createState() => _WebScerrenState();
}

class _WebScerrenState extends State<WebScerren> {
  final PageController _pageController = PageController();
  
  int screenNumber = 0;
  
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: screenNumber==0 ? primaryColor : secondaryColor,
              size: screenNumber == 0? primaryIconSize :secondaryIconSizr,
            ),
            onPressed: () {
              _pageController.jumpToPage(0);
              
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: screenNumber==1 ? primaryColor : secondaryColor,
              size: screenNumber == 1? primaryIconSize :secondaryIconSizr,
            ),
            onPressed: () {
              _pageController.jumpToPage(1);
           
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: screenNumber==2 ? primaryColor : secondaryColor,
              size: screenNumber == 2? primaryIconSize :secondaryIconSizr,
            ),
            onPressed: () {
              _pageController.jumpToPage(2);
          
            },
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: screenNumber==3 ? primaryColor : secondaryColor,
              size: screenNumber == 3? primaryIconSize :secondaryIconSizr,
            ),
            onPressed: () {
              _pageController.jumpToPage(3);
        
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: screenNumber==4 ? primaryColor : secondaryColor,
              size: screenNumber == 4? primaryIconSize :secondaryIconSizr,
            ),
            onPressed: () {
              _pageController.jumpToPage(4);
           
            },
          ),
        ],
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          "assets/img/instagram.svg",
          color: primaryColor,
          height: 32,
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            screenNumber = index ;
            
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children:  [
          Home(),
          Search(),
          AddPost(),
          Center(child: Text("Love u ♥")),
          Profile(userUid: FirebaseAuth.instance.currentUser!.uid,),
        ],
      ),
    );
  }
}
