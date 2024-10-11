import 'package:flutter/foundation.dart';
import 'package:project/models/planet_detail.dart';

class PlanetProvider with ChangeNotifier{
  List<Planet> planetList = [
    Planet(name: "WASP-1", discover: "The Wasp", timeDiscover: "2006", type: Type.bType, date: DateTime.now()),
    Planet(name: "WASP-16", discover: "The Wasp", timeDiscover: "2009", type: Type.dType, date: DateTime.now()),
    Planet(name: "EARTH-616", discover: "OBA", timeDiscover: "1999", type: Type.cType, date: DateTime.now()),

  ];

  List<Planet> getPlanet(){
    return planetList;
  }

  void addPlanet(Planet statement){
    planetList.add(statement);
  }
}