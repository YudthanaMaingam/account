
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/models/planet_detail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PlanetDB{
  String dbName;

  PlanetDB({required this.dbName});

//ถ้ายังไม่ถูกสร้าง => สร้าง
//ถ้าสร้างแล้ว => เปิด
  Future <Database> openDatabase() async{
    //หาตำแหน่งที่จะเก็บข้อมูล
    var appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path,dbName);
    //สร้าง database
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //save ข้อมูล
  Future <int> InsertData(Planet statement) async{
    //ส่งเข้า store
    // plaetnet.db => planet
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("planet");

    //json
    var keyID = store.add(db, {
      "title": statement.name,
      "discover": statement.discover,
      "time": statement.timeDiscover,
      "type": statement.type.toString(), //แปลง enum เป็น String
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }
}