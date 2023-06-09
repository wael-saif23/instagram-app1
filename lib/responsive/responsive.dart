import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:insta_s_m_app/responsive/mopile.dart';
import 'package:insta_s_m_app/responsive/web.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({super.key,required this.myWebScreen,required this.myMobileScreen});
  final myWebScreen;
  final myMobileScreen;
  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return  widget.myWebScreen ;
        } else {
          return widget.myMobileScreen;
        }
      },
    );
  }
}
