import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Sqldb {

    static Database? _db;

   Future<Database?> get db async{
         if(_db == null){
           _db= await intialDb();    
           return _db;
         }else{
            return _db; 
         }
   }




intialDb() async{
  String databasepath = await getDatabasesPath();
  String path = join(databasepath,"ibrahim.db");
  Database mydb = await openDatabase(path,onCreate: _onCreate,version:5 ,onUpgrade: _onUpgrade );

  return mydb;
}
  
_onUpgrade (Database db, int oldversion, int newversion ) async{
  print("onUpgrade ===================================");
  await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
}

_onCreate(Database db,int version) async{
   Batch batch = db.batch();

   batch.execute(
    '''
    CREATE TABLE "notes"(
       id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
       title Text NOT NULL,
       color TEXT,
       note TEXT NOT NULL
    )
    '''
  );
  batch.commit();
  print("Create DATABASE AND TABLE ===============");
}

//Select
read(String table) async{
  Database? mydb = await db;
  List<Map> response = await mydb!.query(table);
  return response;
}

//Insert
Future<int> insert(String table,Map<String, Object?> values) async{
  Database? mydb = await db;
  int response = await mydb!.insert(table,values);
  return response;
} 

//update
update(String table,  Map<String, Object?> value,String?  mywhere) async{
  Database? mydb = await db;
  int response = await mydb!.update(table ,value ,where: mywhere );
  return response;
}
//Delete
delete(String table,String? mywhere) async{
  Database? mydb = await db;
  int response = await mydb!.delete(table, where: mywhere);
  return response;
}






}