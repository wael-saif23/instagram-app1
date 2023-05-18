import 'package:flutter/material.dart';
import 'package:insta_s_m_app/responsive/mopile.dart';
import 'package:insta_s_m_app/responsive/responsive.dart';
import 'package:insta_s_m_app/responsive/web.dart';
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:const ResponsivePage(myMobileScreen: MopileScreen(), myWebScreen:WebScerren() ,)
    );
  }
}