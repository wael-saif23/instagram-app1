import 'package:flutter/material.dart';
import 'package:insta_s_m_app/share/colors.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
            decoration:
                const InputDecoration(labelText: 'Search for a user...'),
          ),
      ),
    );
  }
}