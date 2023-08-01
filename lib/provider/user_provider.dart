 import 'package:flutter/material.dart';
import 'package:insta_s_m_app/firebase_servises/auth.dart';
import 'package:insta_s_m_app/models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userData;
  UserModel? get getUser => _userData;
  
  refreshUser() async {
    UserModel userData = await AuthMethods().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
 }