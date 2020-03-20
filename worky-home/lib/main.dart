import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_course/src/pages/bottom_drawer.dart';

import 'src/theme/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: BottomDrawer(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
