import 'package:flutter/material.dart';

import 'package:insta_s_m_app/provider/user_provider.dart';

import 'package:provider/provider.dart';

class ResponsivePage extends StatefulWidget {
  const ResponsivePage(
      {super.key, required this.myWebScreen, required this.myMobileScreen});
  final Widget myWebScreen;
  final Widget myMobileScreen;
  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  getDataFromDB() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return widget.myWebScreen;
        } else {
          return widget.myMobileScreen;
        }
      },
    );
  }
}
