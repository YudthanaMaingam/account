import 'package:flutter/foundation.dart';
import 'package:project/database/planet_database.dart';
import 'package:project/models/planet_detail.dart';

class PlanetProvider with ChangeNotifier{
  List<Planet> planetList = [];

  List<Planet> getPlanet(){
    return planetList;
  }

  void addPlanet(Planet statement) async {
    var db = PlanetDB(dbName: "planet.db");
    //save ข้อมูล
    await db.InsertData(statement);

    planetList.insert(0,statement);
    //แจ้งเตือน Consumer
    notifyListeners();
  }
}