


import 'package:flutter/material.dart';
import 'package:fincer/view.dart';
import 'package:fincer/addES.dart';
import 'package:fincer/databasehelper.dart';


class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController  _ammountcontroller = TextEditingController();

  int v1;
  //TextEditingController  _label = TextEditingController();
  TextEditingController  _month = TextEditingController();
  TextEditingController  _year = TextEditingController();
  
  
  //final _namecontroller = TextEditingController();


  final dbhelper =  Databasehelper.instance;
  List<Map<String, dynamic>> allrows1;
  int putid =1;
  String addmess = " ";
  int selectrad;
  @override
  void initState() { 
    super.initState();
    selectrad =1;
    
  }
  void setselectrad(int val)
  {
    setState(() {
        selectrad =val;
        });
  }

//keyboardType: TextInputType.number,
void enteredcheck(){
  if ((_ammountcontroller.text).isEmpty || (_month.text).isEmpty || (_year.text).isEmpty  )
  {
    print("data is not entered");
    setState(() {
          addmess = "Please Enter Valid Data";
        });
   
    return ;
  }
  else{
    insertData();
  }
}


  
void insertData() async{

  allrows1 = await dbhelper.queryall();
  if(allrows1.length == null){
    putid = 0;
  }
  else{
    putid = allrows1.length;
    putid = putid++;
  }
  //v1 = _ammountcontroller;
  Map<String,dynamic> row = {
    Databasehelper.columnammount: _ammountcontroller.text,
    Databasehelper.columnlabel:selectrad,
    Databasehelper.columnmonth:_month.text,
    Databasehelper.columnyear:_year.text,
    Databasehelper.columnId:putid,
   
  };
  final id = await dbhelper.insert(row);
  setState(() {
      addmess = " Your Data Is Added";
      //AddEs();
      //very very important
      //
      //
      //

      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddEs()));
      //
      //
      //
      //
    });

  
  print(id);
  print("id");

}
// late added after sdk version 2.12.0
//String value;
call1()
{
  
  print(_ammountcontroller.text);
  //print(_label.text);
  print(_month.text);
  print(_year.text);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,//  lrngth is how much tabbar will be present
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewData()));
          }, child: Text('More',style: TextStyle(color: Colors.white),)),

          ],
        ),
          ),



          body: Wrap(children:[ 
          Card(
            child: Form(
      child: Column(
        children: <Widget>[
            TextFormField(
              controller: _ammountcontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your Ammount',
                labelText: 'Ammount',
              ),
              validator: ( value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),


            Row(children: [Text("Earned"),
              Radio(value: 1,activeColor:Colors.green, groupValue: selectrad, onChanged: (val){print("radio val $val");  setselectrad(val);}),
              
              Text("Spended"),
              Radio(value: 2,activeColor:Colors.green, groupValue: selectrad, onChanged: (val){print("radio val $val");setselectrad(val);}),
              
            ],), 

          
             TextFormField(
                controller: _month,
                decoration: const InputDecoration(
                  hintText: 'Enter Month',
                  labelText: 'month',
                ),
                validator: ( value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              
            TextFormField(
              controller: _year,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter year',
                labelText: 'Year',
              ),
              validator: ( value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),



            Text("$addmess",style: TextStyle(color: Colors.blue),),


            Center(
              child: Padding(
                 padding: EdgeInsets.symmetric(vertical: 1.0), 
                child: ElevatedButton(
                  onPressed: enteredcheck,
                  child: const Text(' Save '),
                ),
              ),
            ),

        ],
      ),
            ),
          )
          ]),

    ),
    ),);
  }
}


