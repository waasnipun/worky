import 'package:flutter/material.dart';
import 'package:login_test/Database/firebase.dart';
import 'package:login_test/Screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home page"),
            RaisedButton(
              child: Text("Log out"),
              onPressed: (){
                AuthProvider().logOut();
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child:LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}