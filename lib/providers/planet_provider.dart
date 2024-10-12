import 'package:flutter/foundation.dart';
import 'package:project/database/planet_database.dart';
import 'package:project/models/planet_detail.dart';

class PlanetProvider with ChangeNotifier{
  List<Planet> planetList = [
    // Planet(name: "WASP-1", discover: "Cameron et al.(SuperWASP and SOPHIE)", timeDiscover: "2006", type: Type.bType, date: DateTime.now()),
    // Planet(name: "WASP-16", discover: "Cameron et al.(SuperWASP and SOPHIE)", timeDiscover: "2009", type: Type.dType, date: DateTime.now()),
    // Planet(name: "Gliese 581", discover: "Stéphane Udry Team", timeDiscover: "2007", type: Type.cType, date: DateTime.now()),

  ];

  List<Planet> getPlanet(){
    return planetList;
  }

  void addPlanet(Planet statement) async {
    var db = await PlanetDB(dbName: "planet.db").openDatabase();
    print(db);
    planetList.insert(0,statement);
    //แจ้งเตือน Consumer
    notifyListeners();
  }
}