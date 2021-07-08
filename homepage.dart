import 'package:fincer/addES.dart';
import 'package:fincer/databasehelper.dart';
import 'package:fincer/view.dart';
import 'package:fincer/variablePage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final dbhelper =  Databasehelper.instance;
void insertData() async{
  Map<String,dynamic> row1 = {
    Databasehelper.columnammount:"app_data",
    Databasehelper.columnlabel:"23",
    Databasehelper.columnmonth:"23",
    Databasehelper.columnyear:"23",
  };
  final id = await dbhelper.insert(row1);
  print(id);
}

String s1 ='jsx';
void callApp()
{
  setState(() {
  print('Button is clicked');
  s1 = 'this is done guys:';
    });
  
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(length: 4,
        child: Scaffold(
          appBar: AppBar(
              title: Text('FinCer'),
              toolbarHeight: 70.0,
              backgroundColor: Colors.blueGrey,//blueAccent,

//making tabbar
            bottom: TabBar(
            tabs: [
              Icon(Icons.camera_alt, size: 25),
              
            TextButton(onPressed:() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEs()));
            }, child: Text('Added',style: TextStyle(color: Colors.white),)),
            TextButton(onPressed:() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewData()));
            }, 
            child: Text('View',style: TextStyle(color: Colors.white),)),

            TextButton(onPressed:() {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VariablePage()));
          }, child: Text('More',style: TextStyle(color: Colors.white),)),

            ],
          ),
            ),
          body:  Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
          
          //Expanded(child: Container(child: Text('after clicking button you will reach at desire page'),)),
          Expanded(child: Image(image: AssetImage('images/img.png'))),
          
          ],
          ), 
        ),
      ),
      
    );
  }
}
