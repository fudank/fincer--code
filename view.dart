import 'package:flutter/material.dart';
import 'package:fincer/addES.dart';
import 'package:fincer/databasehelper.dart';
import 'package:fincer/variablePage.dart';
//import 'package:fincer/view.dart';

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
//final accesdata = TextEditingController();
TextEditingController  accesdata = TextEditingController();
  

final dbhelper = Databasehelper.instance;
  List<Map<String, dynamic>> desiredata;
  bool isLoading = false;


  @override
  void dispose() {
    super.dispose();
  }

  Future desirequery() async {
    setState(() => isLoading = true);
    //Databasehelper.columnyear:_year.text;

    dynamic getyear = accesdata.text;
    this.desiredata = await dbhelper.yearqueries(getyear);
    
    int getammount = desiredata[1]["ammount"];
    int getlabel = desiredata[1]["label"];
    String getmonth = desiredata[1]["month"];

    setState(() => isLoading = false);

    print(getammount);
    print(getlabel);
    print(getmonth);
  }

  @override
  void initState() {
    super.initState();
    desirequery();
  }


void getstr()
{
  setState(() {
      //d.putInfo();
    });
}
call2()
{
  setState(() {
      print(accesdata.text);
    });
}

 String callable(dynamic lable) {
    if (lable == 2) {
      return "Spended";
    }
    return "Earned";
  }
 int getlen() {
    setState(() => isLoading = true);

    if (desiredata != null) {
      
      return desiredata.length;
     
    }
    return 0;
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
          body: Center(child: 
          Card(
            child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(children: [
            TextFormField(

              controller: accesdata,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Year',
                labelText: 'Year',
              ),
              validator: ( value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Padding(
                 padding: EdgeInsets.symmetric(vertical: 1.0), 
                child: ElevatedButton(
                  onPressed: desirequery,
                  child: const Text('View Data'),
                ),
              ),
              ],),
          
          

            Expanded(
              child: Card(
                
              child: ListView.builder(
                
                scrollDirection: Axis.vertical, reverse: false,
                shrinkWrap: true, addRepaintBoundaries: false,
                padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),

                itemCount: getlen(), //allrows.length,
                itemBuilder: (BuildContext context, int index) {
                  //int getlabel2 = allrows[index]["label"];
                  return Datashowed(
                    ammount: desiredata[index]["ammount"],
                    earnspend: (callable(desiredata[index]["label"])),
                    month: desiredata[index]["month"],
                    year: desiredata[index]["year"],
                  );
                },
              ),
          ),
            ),

        ],
      ),
            ),
          )
          ), 
        ),
      ),
      
    );
  }
}

