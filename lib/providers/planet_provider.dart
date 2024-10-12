import 'package:flutter/foundation.dart';
import 'package:project/database/planet_database.dart';
import 'package:project/models/planet_detail.dart';

class PlanetProvider with ChangeNotifier{
  List<Planet> planetList = [];

  List<Planet> getPlanet(){
    return planetList;
  }

    void initData() async{
    var db = await PlanetDB(dbName: "planet.db");
    this.planetList = await db.loadAllData();
    print(this.planetList);
    notifyListeners();
  }

  void addPlanet(Planet statement) async {
    var db = PlanetDB(dbName: "planet.db");
    var keyID = await db.InsertData(statement);
    this.planetList = await db.loadAllData();
    print(this.planetList);
    // await db.InsertData(statement);

    // planetList.insert(0,statement);
    //แจ้งเตือน Consumer
    notifyListeners();
  }

  void deletePlanet(int? index) async {
  if (index != null) {  // ตรวจสอบว่ามีค่า index หรือไม่
    print("delete index: $index");
    var db = await PlanetDB(dbName: "planet.db");
    await db.deleteDatabase(index);  // ลบข้อมูลใน database
    this.planetList = await db.loadAllData();  // โหลดข้อมูลใหม่หลังลบ
    notifyListeners();  // แจ้งให้ UI อัปเดต
  } else {
    print("Error: Index is null, cannot delete.");
  }
}
  void updatePlanet(Planet statement) async {
  var db = await PlanetDB(dbName: "planet.db");

  await db.updateDatabase(statement);
  
  this.planetList = await db.loadAllData();
  
  notifyListeners();
}
}