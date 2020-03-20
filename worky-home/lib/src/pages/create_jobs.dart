import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
class CreateJob extends StatelessWidget {
  CreateJob({Key key}) : super(key: key);
  double width;
  

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
      child: Container(
          height: 85,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.black,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.black)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.black)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                top: 35,
                left: 0,
                child: Container(
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                      // Icon(
                      //   Icons.keyboard_arrow_left,
                      //   color: Colors.white,
                      //   size: 40,
                      // ), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Create a Job Offer",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                                icon: Icon(Icons.close, color: Colors.white),
                                iconSize: 25.0,
                                onPressed: () {
                                  Navigator.pop(context);
                                  },
                            ),
                        ],
                      ),
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

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      body:Container(        
          child: Stack(
              children: <Widget>[
                SingleChildScrollView(            
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 110),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 6.0, 15.0, 20.0),
                        //child:_createNewJob(50),
                        child: MyCustomForm(),
                      ),
                    ],
                  ),
              )),
              _header(context),  
              ]
            ),      
          ),
        );
    }
}

class MyCustomForm extends StatefulWidget {


  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _jobTitle = TextEditingController(text: "");
  TextEditingController _jobType = TextEditingController(text: "");
  TextEditingController _jobPrice = TextEditingController(text: "");
  TextEditingController _jobLocation = TextEditingController(text: "");
  TextEditingController _jobWorkingHours = TextEditingController(text: "");
  TextEditingController _jobDescription = TextEditingController(text: "");
  TextEditingController _jobMobileNumber = TextEditingController(text: "");
  TextEditingController _jobEmail = TextEditingController(text: "");
  TextEditingController _userID = TextEditingController(text: "");
  insertData() async{
    String url = "https://worky-flutter.000webhostapp.com/insertData_waas.php";
    var res = await http.post(Uri.encodeFull(url),headers:{"Accept":"application/json"},body:{
      "jobTitle":_jobTitle.text,
      "jobType":_jobType.text,
      "jobPrice":_jobPrice.text,
      "jobLocation":_jobLocation.text,
      "jobWorkingHours":_jobWorkingHours.text,
      "jobDescription":_jobDescription.text,
      "jobMobileNumber":_jobMobileNumber.text,
      "jobEmail":_jobEmail.text,
      "userID":"23",
    }
    );
    var responseBody = json.decode(res.body);
    print(responseBody);
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _textFields(_jobTitle, _jobType, _jobPrice,_jobLocation,_jobWorkingHours,_jobDescription,_jobMobileNumber,_jobEmail,context),       
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: MaterialButton(
                  minWidth: 100,
                  onPressed: () async {
                    
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(duration: const Duration(seconds: 2),content: Text('Processing Data...'),backgroundColor: Colors.blue,));
                      insertData();
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text('Saved!'),backgroundColor: Colors.blue,));  
                      await Future.delayed(const Duration(seconds : 3));
                      Navigator.pop(context);
                    }
                    else{
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(duration: const Duration(seconds: 1),content: Text('Error Occured'),backgroundColor: Colors.red,));
                    }                                                 
                },
                child: Text('Submit',style: TextStyle(fontSize: 15)),
                color: Colors.black,
                textColor: Colors.white,              
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey)
                ),
              ),
            ),
          ],
        ),
    );
  }
}
Widget _textFields(var _jobTitle,var _jobType,var _jobPrice,var _jobLocation,var _jobWorkingHours,var _jobDescription,var _jobMobileNumber,var _jobEmail,BuildContext context){
    return Container(
      padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    decorationColor: Colors.black,//Font color change
                  ),
                controller: _jobTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your Job Title',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            SizedBox(height: 20),
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                      controller: _jobType,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Job Type',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            SizedBox(height: 20),
            Align(
              alignment:Alignment.bottomLeft,
              child:Text(
                "Job Details",                      
                ),),
              SizedBox(height: 20),
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                    controller: _jobPrice,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.attach_money),
                      labelText: 'Price'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                    controller: _jobLocation,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.add_location),
                      labelText: 'Location'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                    controller: _jobWorkingHours,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.timer),
                      labelText: 'Working Hours'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),            
            
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                    controller: _jobDescription,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 30.0),
                      border: OutlineInputBorder(),
                      labelText: 'Description'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
            SizedBox(height: 20),
            Align(
              alignment:Alignment.bottomLeft,
              child:Text(
                "Contact Details",                      
                ),),
              SizedBox(height: 20),
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                    controller: _jobMobileNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.call),
                      labelText: 'Mobile Number'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
               )),
            Material(
              color: Colors.white54,
              borderRadius: new BorderRadius.circular(8.0),
              child:TextFormField(
                    controller: _jobEmail,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.email),
                      labelText: 'Email'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                )),
              ],
            ),
          );
        }
            
