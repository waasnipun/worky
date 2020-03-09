import 'dart:async';
import 'dart:ui';
import 'package:login_test/Screens/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StartPage extends StatefulWidget {
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      loadData();
    }  
      Future<Timer> loadData() async {
        return new Timer(Duration(seconds: 2), onDoneLoading);
      }
    
      onDoneLoading() {
       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
       
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRight, child:LoginScreen()));
      }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                           ColorizeAnimatedTextKit(
                               duration: Duration(milliseconds: 2000),
                                onTap: () {
                                  print("Tap Event");
                                },                 
                                 text: [
                                  ' Worky',
                                ],
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'BreeSerif',
                                    fontSize: 50.0
                                ),
                                colors: [                           
                                  Colors.black,
                                  Colors.white10,
                                  Colors.black,
                                ],
                                textAlign: TextAlign.start,
                                alignment: AlignmentDirectional
                                    .topStart // or Alignment.topLeft
                            ),    
                        ],
                      ),
                    ),
                ),   
              ],
            )
          ],
        ),
      );
    }

}
