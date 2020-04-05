import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/job_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_course/src/helper/quad_clipper.dart';
import 'package:flutter_smart_course/src/pages/recomended_page.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  //HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response;
  double width;
  int count_nearby_data = 0;
  String _clientDistrict = "kalutara";

  @override
  void initState() {
    super.initState();
    getGigData().whenComplete(() {
      print("done");
    });
  }

  var _appearance = {
    'type_one': [
      LightColor.seeBlue,
      LightColor.lightseeBlue,
      LightColor.lightBlue
    ],
    'type_two': [Colors.white, LightColor.seeBlue, Colors.white],
    'type_three': [Colors.white, LightColor.lightOrange, Colors.white],
    'type_four': [
      Colors.white,
      LightColor.seeBlue,
      LightColor.seeBlue,
      LightColor.lightseeBlue,
      LightColor.darkseeBlue
    ]
  };

  Future getGigData() async {
    try {
      String url =
          "https://worky-flutter.000webhostapp.com/clientGetGigData.php";
      var res = await http.post(Uri.encodeFull(url), headers: {
        "Accept": "application/json"
      }, body: {
        "client_district": _clientDistrict,
      });
      setState(() {
        response = json.decode(res.body);
        count_nearby_data = response.length;
      });
    } on Exception catch (e) {
      print("Pass");
    }
  }

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Container(
          height: 180,
          width: width,
          decoration: BoxDecoration(
            color: Colors.pink,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, Colors.pink[400])),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, Colors.pink[600])),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 45,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 50,
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6.0,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    //controller: passwordControl,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'OpenSans',
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 15.0),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        hintText: 'Search Workers',
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'OpenSans',
                                        )),
                                  ))
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )))
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: width * 0.38),
          new SizedBox(
            width: width * 0.08,
            height: 30.0,
            child: RaisedButton(
                padding: EdgeInsets.all(1.0),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () {
                  getGigData();
                },
                color: Colors.grey,
                textColor: Colors.white,
                child: Icon(Icons.refresh)),
          ),
          _chip("See all", primary)
        ],
      ),
    );
  }

  Widget cardA(String workDetail, String type, String workerName, String price,
      String email, String district, String heads, String duration, String DN) {
    return _card(
        heads: heads,
        duration: duration,
        DN: DN,
        district: district,
        email: email,
        price: price,
        name: workerName,
        primary: LightColor.seeBlue,
        backWidget: _decorationContainerA(LightColor.lightseeBlue, 50, -30),
        chipColor: LightColor.lightBlue,
        workDetail: workDetail,
        type: type,
        isPrimaryCard: true,
        imgPath:
            "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg");
  }

  Widget cardB(String workDetail, String type, String workerName, String price,
      String email, String district, String heads, String duration, String DN) {
    return _card(
        heads: heads,
        duration: duration,
        DN: DN,
        district: district,
        email: email,
        price: price,
        name: workerName,
        primary: Colors.white,
        chipColor: LightColor.seeBlue,
        backWidget: _decorationContainerB(Colors.white, 90, -40),
        workDetail: workDetail,
        type: type,
        imgPath:
            "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*");
  }

  Widget cardC(String workDetail, String type, String workerName, String price,
      String email, String district, String heads, String duration, String DN) {
    return _card(
        heads: heads,
        duration: duration,
        DN: DN,
        district: district,
        email: email,
        price: price,
        name: workerName,
        primary: Colors.white,
        chipColor: LightColor.lightOrange,
        backWidget: _decorationContainerC(Colors.white, 50, -30),
        workDetail: workDetail,
        type: type,
        imgPath:
            "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg");
  }

  Widget cardD(String workDetail, String type, String workerName, String price,
      String email, String district, String heads, String duration, String DN) {
    return _card(
        heads: heads,
        duration: duration,
        DN: DN,
        district: district,
        email: email,
        price: price,
        name: workerName,
        primary: Colors.white,
        chipColor: LightColor.seeBlue,
        backWidget: _decorationContainerD(LightColor.seeBlue, -50, 30,
            secondary: LightColor.lightseeBlue,
            secondaryAccent: LightColor.darkseeBlue),
        workDetail: workDetail,
        type: type,
        imgPath:
            "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg");
  }

  Widget _featuredRowA() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            cardA(
                response[0]['workDetail'],
                response[0]['type'],
                response[0]['name'],
                response[0]['price'],
                response[0]['email'],
                response[0]['district'],
                response[0]['heads'],
                response[0]['duration'],
                response[0]['DN']),
            cardB(
                response[1]['workDetail'],
                response[1]['type'],
                response[1]['name'],
                response[1]['price'],
                response[1]['email'],
                response[1]['district'],
                response[1]['heads'],
                response[1]['duration'],
                response[1]['DN']),
            cardC(
                response[2]['workDetail'],
                response[2]['type'],
                response[2]['name'],
                response[2]['price'],
                response[2]['email'],
                response[2]['district'],
                response[2]['heads'],
                response[2]['duration'],
                response[2]['DN']),
            cardD(
                response[3]['workDetail'],
                response[3]['type'],
                response[3]['name'],
                response[2]['price'],
                response[3]['email'],
                response[3]['district'],
                response[3]['heads'],
                response[3]['duration'],
                response[3]['DN']),
          ],
        ),
      ),
    );
  }

//  Widget _featuredRowB() {
//    return SingleChildScrollView(
//      scrollDirection: Axis.horizontal,
//      child: Container(
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          crossAxisAlignment: CrossAxisAlignment.end,
//          children: <Widget>[
//            _card(
//                primary: LightColor.seeBlue,
//                chipColor: LightColor.seeBlue,
//                backWidget: _decorationContainerD(
//                    LightColor.darkseeBlue, -100, -65,
//                    secondary: LightColor.lightseeBlue,
//                    secondaryAccent: LightColor.seeBlue),
//                chipText1: "English for career development ",
//                chipText2: "8 Cources",
//                isPrimaryCard: true,
//                imgPath:
//                    "https://www.reiss.com/media/product/946/218/silk-paisley-printed-pocket-square-mens-morocco-in-pink-red-20.jpg?format=jpeg&auto=webp&quality=85&width=1200&height=1200&fit=bounds"),
//            _card(
//                primary: Colors.white,
//                chipColor: LightColor.lightpurple,
//                backWidget: _decorationContainerE(
//                  LightColor.lightpurple,
//                  90,
//                  -40,
//                  secondary: LightColor.lightseeBlue,
//                ),
//                chipText1: "Bussiness foundation",
//                chipText2: "8 Cources",
//                imgPath:
//                    "https://i.dailymail.co.uk/i/pix/2016/08/05/19/36E9139400000578-3725856-image-a-58_1470422921868.jpg"),
//            _card(
//                primary: Colors.white,
//                chipColor: LightColor.lightOrange,
//                backWidget: _decorationContainerF(
//                    LightColor.lightOrange, LightColor.orange, 50, -30),
//                chipText1: "Excel skill for business",
//                chipText2: "8 Cources",
//                imgPath:
//                    "https://www.reiss.com/media/product/945/066/03-2.jpg?format=jpeg&auto=webp&quality=85&width=632&height=725&fit=bounds"),
//            _card(
//                primary: Colors.white,
//                chipColor: LightColor.seeBlue,
//                backWidget: _decorationContainerA(
//                  Colors.white,
//                  -50,
//                  30,
//                ),
//                chipText1: "Beacame a data analyst",
//                chipText2: "8 Cources",
//                imgPath:
//                    "https://img.alicdn.com/imgextra/i4/52031722/O1CN0165X68s1OaiaYCEX6U_!!52031722.jpg"),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _card(
      {Color primary = Colors.redAccent,
      String heads = '',
      String DN = '',
      String duration = '',
      String district = '',
      String email = '',
      String price = '',
      String name = '',
      String imgPath,
      String workDetail = '',
      String type = '',
      Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseInfoScreen(),
              settings: RouteSettings(
                arguments:
                    ScreenArguments(type, district, workDetail, price, email, heads, duration, DN),
              ),
            ),
          );
        },
        child: Container(
            height: 180,
            width: width * .32,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: primary.withAlpha(200),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      color: LightColor.lightpurple.withAlpha(20))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                child: Stack(
                  children: <Widget>[
                    backWidget,
                    Positioned(
                        top: 20,
                        left: 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: NetworkImage(imgPath),
                        )),
                    Positioned(
                      top: 70,
                      left: 10,
                      child: _nameInfo(name, LightColor.titleTextColor),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: _cardInfo(workDetail, type,
                          LightColor.titleTextColor, chipColor,
                          isPrimaryCard: isPrimaryCard),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          SizedBox(height: 5),
          _chip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  Widget _nameInfo(String title, Color textColor) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: textColor.withAlpha(50),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 12),
          ),
        ));
  }

  Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left,
      {Color secondary, Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left,
      {Color secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.star_border),
            _bottomIcons(Icons.book),
            _bottomIcons(Icons.person),
          ],
//          onTap: (index) {
//            Navigator.pushReplacement(context,
//                MaterialPageRoute(builder: (context) => RecomendedPage()));
//          },
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              _header(context),
              SizedBox(height: 20),
              _categoryRow(
                  "Near by workers", LightColor.orange, LightColor.orange),
              _featuredRowA(),
              SizedBox(height: 0),
              _categoryRow(
                  "Suggested", LightColor.purple, LightColor.darkpurple),
              //_featuredRowB()
            ],
          ),
        )));
  }
}
