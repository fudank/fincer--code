import 'package:fincer/view.dart';
import 'package:fincer/addData.dart';
import 'package:fincer/variablePage.dart';
import 'package:flutter/material.dart';
//import 'package:fincer/clickview.dart';

import 'databasehelper.dart';

class AddEs extends StatefulWidget {
  @override
  _AddEsState createState() => _AddEsState();
}

class _AddEsState extends State<AddEs> {
  final dbhelper = Databasehelper.instance;
  List<Map<String, dynamic>> allrows;
  bool isLoading = false;

  @override
void dispose() {
    super.dispose();
  }

  Future queryall() async {
    setState(() => isLoading = true);
    

    this.allrows = await dbhelper.queryall();
    
   
    setState(() => isLoading = false);
  
    //print(allrows.length);
   
  }

  @override
  void initState() {
    super.initState();
    queryall();
  }

  String callable(dynamic lable) {
    if (lable == 2) {
      return "Spended";
    }
    return "Earned";
  }

  int getlen() {
    setState(() => isLoading = true);

    if (allrows != null) {
      return allrows.length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4, //  lrngth is how much tabbar will be present
        child: Scaffold(
          appBar: AppBar(
            title: Text('FinCer'),
            toolbarHeight: 70.0,
            backgroundColor: Colors.blueGrey,

//making tabbar
            bottom: TabBar(
              tabs: [
                Icon(Icons.camera_alt, size: 25),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddEs()));
                    },
                    child: Text(
                      'Added',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ViewData()));
                    },
                    child: Text(
                      'View',
                      style: TextStyle(color: Colors.white),
                    )),
                    TextButton(onPressed:() {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VariablePage()));
          }, child: Text('More',style: TextStyle(color: Colors.white),)),

              ],
            ),
          ),
          body: Center(
            child: ListView.builder(
              scrollDirection: Axis.vertical, reverse: false,
              shrinkWrap: true, addRepaintBoundaries: false,
              padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),

              itemCount: getlen(), //allrows.length,
              itemBuilder: (BuildContext context, int index) {
                //int getlabel2 = allrows[index]["label"];
                return Datashowed(
                  ammount: allrows[index]["ammount"],
                  earnspend: (callable(allrows[index]["label"])),
                  month: allrows[index]["month"],
                  year: allrows[index]["year"],
                  id: allrows[index]["id"],
                );
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddData()));
            },
          ),
        ),
      ),
    );
  }
}

class Datashowed extends StatelessWidget {



  //required keyword adding after sdk version 2.12.0
  Datashowed({Key key,this.ammount, this.earnspend, this.month, this.year,this.id})
      : super(key: key);
  final int ammount;
  final String earnspend;
  final String month;
  final int year;
  final int id;
  viewed() {
    print('data is viewed you can viewed new data');
    print(ammount);
    print(earnspend);
    print(month);
    print(year);
  }

  dynamic context1(String s)
  {
    s = "jbyg";
  }


  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        color: const Color.fromARGB(255, 220, 220, 220),
        margin: EdgeInsets.all(1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Text(
              'Rs.   ' + this.ammount.toString(),
              style: TextStyle(color: Colors.black),
            )),
           // Icon(Icons.save),
            Column(
              children: [
                Text(
                  this.earnspend.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      this.month,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text("   "),
                    Text(
                      this.year.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed:  () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddData1State(id:this.id,ammount: this.ammount,earnspend: this.earnspend,
                          month: this.month,year: this.year,desc: "this is description",)));
                    }, 
              child: Text(
                "View",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(onPrimary: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}






/* // making widget for adding data
Widget _buildPopupDialog1(BuildContext context) {
  return new AlertDialog(
    title:  Text("Your  data "),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hellof"),
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        /* textColor: Theme.of(context).primaryColor, */
        child: const Text('Delete'),
       
      ),
      
      ElevatedButton(onPressed: null, child: Text("close")),
    ],
  );
}

 */





class AddData1State extends StatelessWidget {
AddData1State({Key key, this.ammount, this.earnspend, this.month, this.year,this.id,this.desc})
     : super(key: key);
  final int ammount;
  final String earnspend;// attention
  final String month;
  final String desc;
  final int year;
  final int id;
  


final dbhelper = Databasehelper.instance;
final String messege = "After clicking Delete button your data will get deleted";


deletedata()
{
  
  dbhelper.deletedata(this.id);
  print("your data is deleted ${this.id}");
}

edit() async
{
  //dbhelper.update( this.ammount, this.earnspend, this.month, this.year, this.id);
  print("object");
  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddData()));
}



  viewed1() {
    print('data is viewed you can viewed new datafffff');
    print(ammount);
    print(earnspend);
    print(month);
    print(year);
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VariablePage()));
          }, child: Text('More',style: TextStyle(color: Colors.white),)),
          ],
        ),
          ),



          body: Center(child: Card(
        color: const Color.fromARGB(255, 220, 220, 220),
        margin: EdgeInsets.all(1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ Text(
                'Rs.   ' + this.ammount.toString(),
                style: TextStyle(color: Colors.black),
              ),
             // Icon(Icons.save),
              
                  Text("This  is the details of  "+
                    this.earnspend.toString()+" on",
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        this.month,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text("   "),
                      Text(
                        this.year.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                     
                    ],
                    
                  ),
                   Text("Description -> "+
                        this.desc.toString(),
                        style: TextStyle(color: Colors.black),
                      ),

               Card(child: Text("$messege",style: TextStyle(color: Colors.red),),),

              ElevatedButton(
                onPressed:  (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VariablePage())); edit();},
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(onPrimary: Colors.green),
              ),


             
                 ElevatedButton(
                  onPressed: deletedata,
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(onPrimary: Colors.green),
                ),
           



            ],
          ),
        ),
      ),
          ),
    ),
    ),
    );
  }
}


