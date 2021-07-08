import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//creating class for databases
class Databasehelper {
  static final _databasename = "person.db";
  static final _databaseversion = 1;
  static final table = "my_table1";
  static final columnId = "id";
  static final columnammount = "ammount";

  static final columnlabel = "label";
  static final columnmonth = "month";
  static final columnyear = "year";

// here table,columnId, columnname,columnage will be used in dart method/function
   static Database _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database> get database async{
    if(_database !=  null)
    {
      return _database;
    }
    else{
      _database = await _initDatabase1(); // this is a method wich will create new database
      return _database;
    }
  }

  //this method will create new database
_initDatabase1() async{
  //getting path from device for creating database
  Directory documentdirectory = await getApplicationDocumentsDirectory();
  //joinig path of database with our application
  String path = join(documentdirectory.path,_databasename);
  return await openDatabase(path,version: _databaseversion,onCreate: _oncreate1);
}

Future _oncreate1(Database db,int version) async {
  await db.execute('''
  CREATE TABLE $table(
    $columnId INTEGER PRIMERY KEY ,
    $columnammount INTEGER NOT NULL,
    $columnlabel INTEGER NOT NULL,
    $columnmonth TEXT NOT NULL,
    $columnyear INTEGER NOT NULL
  )'''
  );
}

// now we will write custom function for insert, delete ,update,and retrieve

Future<int> insert(Map<String,dynamic>row) async {
Database db = await instance.database;

return await db.insert(table, row);
}
//for query all data
Future<List<Map<String,dynamic>>> queryall() async{
  Database db = await instance.database;
  return db.query(table);
}


Future<List<Map<String,dynamic>>> yearqueries(String inputyear) async{
  Database db = await instance.database;
  
  return db.rawQuery('SELECT * FROM my_table1 WHERE year = $inputyear');
}

// query for deleting data
deletedata(int inputid) async
{
   Database db = await instance.database;
   // here my_table1 = table
   var res = await db.delete(table,where: "id = $inputid");
   return res;
}

//query for update data 
update(int ammount,String earnspend,String month,int year,int inputid) async
{
  Database db =  await instance.database;
  var res = await db.update(table, {"ammount":"$ammount","label":"$earnspend","month":"$month","year":"$year"},where: "id = $inputid",whereArgs:[inputid]);
  return res;
}

Future<List<Map<String,dynamic>>> querybyid(String inputid) async{
  Database db = await instance.database;
  
  return db.rawQuery('SELECT * FROM my_table1 WHERE year = $inputid');
}

}
