import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/models/planet_detail.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PlanetDB {
  String dbName;

  PlanetDB({required this.dbName});

//ถ้ายังไม่ถูกสร้าง => สร้าง
//ถ้าสร้างแล้ว => เปิด
  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    var appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    //สร้าง database
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //save ข้อมูล
  Future<int> InsertData(Planet statement) async {
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
    print('Added planet with keyID: $keyID');
    return keyID;
  }

// ดึงข้อมูล
Future<List<Planet>> loadAllData() async {
  var db = await this.openDatabase();
  var store = intMapStoreFactory.store("planet");
  var snapshot = await store.find(db,
      finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
  List<Planet> planetList = [];

  for (var record in snapshot) {
    // ตรวจสอบค่า type ก่อนแปลงเป็น enum
    var typeValue = record["type"].toString();
    Type typeEnum;

    try {
      typeEnum = Type.values.firstWhere((e) => e.toString() == typeValue);
    } catch (e) {
      // กรณีที่ไม่พบค่าให้ใช้ค่าเริ่มต้นหรือจัดการตามต้องการ
      typeEnum = Type.noneType; // แทนที่ด้วยค่าเริ่มต้น
      // หรือใช้การแจ้งเตือนหากต้องการ
      print('Error: Type not found for value: $typeValue');
    }

    planetList.add(Planet(
        keyID: record.key,
        name: record["title"].toString(),
        discover: record["discover"].toString(),
        timeDiscover: record["time"].toString(),
        type: typeEnum,
        date: DateTime.parse(record["date"].toString())));
  }

  db.close();
  return planetList;
}

  deleteDatabase(int index) async {
  var db = await this.openDatabase();
  var store = intMapStoreFactory.store("planet");
  await store.delete(db, finder: Finder(filter: Filter.equals(Field.key, index)));
  db.close();
}

Future<void> updateDatabase(Planet statement) async {
  if (statement.keyID == null) {
    print('Error: keyID is null. Cannot update.');
    return; // ออกก่อนหาก keyID เป็น null
  }

  var db = await this.openDatabase();
  var store = intMapStoreFactory.store("planet");
  var filter = Finder(filter: Filter.equals(Field.key, statement.keyID));

  try {
    var result = await store.update(db, finder: filter, {
      "title": statement.name,
      "discover": statement.discover,
      "timeDiscover": statement.timeDiscover,
      "type": statement.type.toString(), // ใช้ค่าที่แปลงจาก enum
      "date": statement.date.toIso8601String()
    });

    if (result == 0) {
      print('No rows updated. Please check if the keyID is correct.');
    } else {
      print('Update successful. Rows affected: $result');
    }
  } catch (e) {
    print('Error occurred during update: $e');
  } finally {
    db.close();
  }
}
}
