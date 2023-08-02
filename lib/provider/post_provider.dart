 import 'package:flutter/material.dart';

import 'package:insta_s_m_app/firebase_servises/firestore.dart';
import 'package:insta_s_m_app/models/posts.dart';


class PostsProvider with ChangeNotifier {
  PostsModel? _postsData;
  PostsModel? get getPosts => _postsData;
  
  refreshUser() async {
    PostsModel postsData = await FirestoreMethods().getPostsDetails();
    _postsData = postsData;
    notifyListeners();
  }
 }