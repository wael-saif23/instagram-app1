import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_s_m_app/provider/user_provider.dart';
import 'package:insta_s_m_app/responsive/mopile.dart';
import 'package:insta_s_m_app/responsive/responsive.dart';
import 'package:insta_s_m_app/responsive/web.dart';

import 'package:insta_s_m_app/screens/sign_in.dart';
import 'package:insta_s_m_app/share/snackbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAqfApq_WN29xxb-kIiuKablzfoq9owFyE",
            authDomain: "instagram-7579b.firebaseapp.com",
            projectId: "instagram-7579b",
            storageBucket: "instagram-7579b.appspot.com",
            messagingSenderId: "943041985172",
            appId: "1:943041985172:web:dbd7f171ab271322779281"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return const ResponsivePage(
                myMobileScreen: MopileScreen(),
                myWebScreen: WebScerren(),
              );
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
