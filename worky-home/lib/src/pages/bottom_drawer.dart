import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/job_page.dart';
import 'package:flutter_smart_course/src/pages/recomended_page.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';

import 'home_page.dart';


class BottomDrawer extends StatefulWidget {

  @override
  _BottomDrawerState createState() => _BottomDrawerState();
  
}

class _BottomDrawerState extends State<BottomDrawer> {
 
  int _currentIndex  = 0;
    final _pageOptions = [
        HomePage(),
        RecomendedPage(),
        JobsPage(),
        HomePage(),
    ];
 
 
  @override
  Widget build(BuildContext context) {   
    return new Scaffold(
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting ,
        onTap: (index) => setState(() {
              _currentIndex = index;
              
          }),
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),       
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Find'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Diary'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
          ),          
        ],
      ),
    );

    
  }
 
}
