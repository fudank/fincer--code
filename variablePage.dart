import 'package:flutter/material.dart';
import 'package:fincer/view.dart';
import 'package:fincer/databasehelper.dart';
import 'package:fincer/addES.dart';

/* 
This requires the 'non-nullable' language feature to be enabled.
Try updating your pubspec.yaml to set the minimum 
SDK constraint to 2.12.0 or higher, and running 'pub get
 */



class VariablePage extends StatefulWidget {
  const VariablePage({ Key key }) : super(key: key);

  @override
  _VariablePageState createState() => _VariablePageState();
}

class _VariablePageState extends State<VariablePage> {

int a;
@override
void initState() { 
  super.initState();
  a =0;
  yearwisedata1();
  
}

void dispose() {
    super.dispose();
    yearwisedata();
  }

final dbhelper =  Databasehelper.instance;

List<Map<String, dynamic>> alldata;
Map<int,int> earn = {1:1};
// this is only for initialization                                (vvi)
Map<int,int> spend = {1:1};
Set<int> s = {1};
Set<int> ss = {1};

bool check(int y1)
{
  for(int c in earn.keys)
  {
    if(c==y1)
    {
      return true;
    }
  }
  return false;
  
}








yearwisedata1() async
{
  
    
    
    this.alldata =  await dbhelper.queryall();
    
    print(alldata.length);
    print(earn.length);
    
    for(int i=0;i<alldata.length;i++)
    {
      int yy = alldata[i]["year"];
      int am = alldata[i]["ammount"];
      
      
      print(s.elementAt(0));
      
      if(alldata[i]["label"] == 1)
      {
        s.add(yy);
        if(check(yy))
        {
          int d = earn[yy];
          int d1 = d+am;
          earn[yy] = d1;
          print("on $i and ${earn.length}  ${earn[yy]}");
          
          
        }
        else
        {
          earn[yy] = am;
          print("on $i and ${earn.length}  ${earn[yy]}");
          
        }
        
      }
      if(alldata[i]["label"] == 2)
      {
        ss.add(yy);
        //earn[1] = 2;
        if(check(yy))
        {
          int dd = earn[yy];
          int dd1 = dd+am;
          spend[yy] = dd1;
          
          
        }
        else
        {
          spend[yy] = am;
        }
        
      }

    }
    
}
yearwisedata()
{
  setState(()  {

      a =1;
     
    });
}
earneddata()
{
  setState(() {
      a = 3;
    });
}
spenddata()
{
  setState(() {
      a = 4;
    });
}

void moreabout()
{
  setState(() {
      a =5;
     
    });
}




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,//  length is how much tabbar will be present
        child: Scaffold(
          appBar: AppBar(
            title: Text('FinCer'),
            
            
            toolbarHeight: 70.0,
            backgroundColor: Colors.blueGrey,

//making tabbar
          bottom: TabBar(
          tabs: [
            Icon(Icons.camera_alt, size: 25),
            
          TextButton(onPressed:() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEs()));
            }, child: Text('Added',style: TextStyle(color: Colors.white),)),
          TextButton(onPressed:() {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewData()));
          }, child: Text('View',style: TextStyle(color: Colors.white),)),
          TextButton(onPressed:() {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VariablePage()));
          }, child: Text('More',style: TextStyle(color: Colors.white),)),

          ],
        ),
          ),



          body: Center(
            child: Column(children:[ 
            /* ElevatedButton(onPressed: test, child: Text("Test")),
            ///after calling test button fist widget will apear
            if(a ==1) first() ,first1(), */
            if(a ==0) Column(children: [
            ElevatedButton(onPressed: yearwisedata, child: Text("Cheak All Data Yearwise")) ,
            ElevatedButton(onPressed: earneddata, child: Text("Cheak All Earned of Data")),
            ElevatedButton(onPressed: spenddata, child: Text("Cheak All Spended of Data")),
            ElevatedButton(onPressed: moreabout, child: Text("Know More About Us")),
            ],
            ),

            if(a == 1) yeardata(earn,s,"Earned"),
            if(a == 1) yeardata(spend,s,"Spended"),

            if(a == 3) yeardata(earn,s,"Earned"),
            if(a == 4) yeardata(spend,s,"Spended"),
            if(a == 5) more(),
            
            
           
            ]),
          ),

    ),
    ),
    );
    }
}
/* Link more1()
{
  return Link("https://heartbeat.fritz.ai/using-the-camera-gallery-in-flutter-apps-2f9e8e0e5899");
            
} */

Widget more()
{
  return Center(child: Text("this is our information",style: TextStyle(color: Colors.blue,fontSize: 23),));
}

Widget first1()
{
  
  return Text("hello tyjgh");
}
Widget yeardata(Map<int,int>earnn,Set<int>s,String str1) 
{
  
  return Wrap(direction: Axis.vertical,
   children: List.generate(earnn.length-1, (i){
     return Card(color: Colors.white30, child: Column(children: [
       Text("This data is of $str1",style: TextStyle(fontSize: 20),),
       //here +1 added for leaving 1st element of set and map
       Text("This data is of year ${s.elementAt(i+1)} ",style: TextStyle(fontSize: 15),),
       Text("Your total earning in ${s.elementAt(i+1)} is ${earnn[s.elementAt(i)]}",style: TextStyle(fontSize: 15,color: Colors.red),),
     ],),);
     }
     )
     );
}


//final build apk
//
//build\app\outputs\flutter-apk\app-release.apk