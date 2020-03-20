import 'dart:convert';
import 'package:flutter_smart_course/src/pages/create_jobs.dart';
import 'package:flutter_smart_course/src/pages/job_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class JobsPage extends StatelessWidget {
  
  JobsPage({Key key}) : super(key: key);
  double width;
  ScrollController _scrollController = ScrollController();

  RefreshController _refreshController =    RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  getData()async{
    String url = "https://worky-flutter.000webhostapp.com/getData_waas.php";
    var res = await http.get(Uri.encodeFull(url),headers:{"Accept":"application/json"});
    var responseBody = json.decode(res.body);
    return responseBody;
  }
  
  deleteDataConfirm(var name,BuildContext context,var id){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete ?"),
      actions: <Widget>[
        RaisedButton(
          child: Text("DELETE",style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed:(){
            deletData(id);
            Navigator.of(context,rootNavigator: true).pop('alertDialog');
          },
        ),
        RaisedButton(
          child: Text("CANCEL",style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed: () async {
                  Navigator.pop(context);
              }
        )
      ],
    );
    showDialog(context: context, child:alertDialog);
  }

  deletData(var id)async{
    String url = "https://worky-flutter.000webhostapp.com/deleteData_waas.php";
    print("id");print(id);
    http.post(url,body:{
      'id': id,
    });
  }
  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
      child: Container(
          height: 85,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.black
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, LightColor.black)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, LightColor.black)),
              Positioned(
                  top: -230,
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
                            "Job",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
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

  Widget _createNewJob(BuildContext context,double height){
    return Container(      
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.grey.shade200),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle, color: LightColor.black),
                iconSize: 50.0,
                onPressed: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child:CreateJob()));
                },
              ),
              SizedBox(width: 5.0),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 2.0),
                    Text(
                      'Create a New Job',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                        ),
                        SizedBox(height: 4.0),
                    Text(
                        'Click here ',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 10.0),
                      ),
                  ],
                ),
              ),
              // SizedBox(width: 40.0),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                iconSize: 30.0,
                onPressed: () {
                  Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child:CreateJob()));
                  },
                )              
              )              
            ],
        ),      
    );
  }

 Widget _body(BuildContext context){
      return Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 110),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 6.0, 15.0, 20.0),
                    child:_createNewJob(context,50),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                    child:Text(
                      "Your Create Jobs",                      
                      ),
                    ),                  
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                    child: SizedBox(
                      height: 323,
                      // padding: EdgeInsets.only(left: 10.0,right: 10,bottom: 20,top: 10),
                      child: FutureBuilder(
                            future: getData(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              List snap = snapshot.data;
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if(snapshot.hasError){
                                return Center(child: Text("Error!"),);
                              }
                              else if(snap.length==0){
                                return Center(child: Text("No Jobs Found"),);
                              }
                              return ListView.builder(
                                itemCount: snap.length,
                                controller: _scrollController,
                                itemBuilder: (context,index){
                                  return Card(
                                    child:SingleChildScrollView(
                                      child:ListTile(
                                      leading: Icon(Icons.work),
                                      title: Text("${snap[index]['jobTitle']}"),
                                      subtitle:  Text("${snap[index]['jobDescription']}"),
                                      isThreeLine: true,
                                      enabled: true,
                                      dense: true,
                                      onTap: ()=>Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child:JobDetails())),
                                      onLongPress: (){
                                        // do something else
                                      },
                                    trailing: Icon(Icons.arrow_forward_ios), 
                                  )));
                                },
                              );
                            },
                        ),       
                      ),
                    ),
                ],
                  ),
             );
 }

   

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      body:SmartRefresher(
         header: WaterDropHeader(),
          enablePullDown: true,
          controller: _refreshController,          
          onRefresh: _onRefresh,   
          child:Container(        
            child: Stack(
                children: <Widget>[
                _header(context),              
                _body(context),
                ],
            ),          
          ),
        ),               
      );    
  
  }



}
