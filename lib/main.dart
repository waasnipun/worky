import 'package:flutter/material.dart';
import 'package:login_test/Screens/Start.dart';
import 'package:login_test/Screens/login_screen.dart';
import 'package:login_test/Screens/waiting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_test/Home/homePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        if(!snapshot.hasData || snapshot.data == null)
          return StartPage();
        return HomePage();
      },
    );
  }
}