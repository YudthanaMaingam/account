import 'package:flutter/foundation.dart';
import 'package:project/models/Planet.dart';

class PlanetProvider with ChangeNotifier{
  List<Planet> transaction = [
    Planet(name: "WASP-1", discover: "The Wasp", timeDiscover: "2006", type: "b", date: DateTime.now()),
    Planet(name: "WASP-16", discover: "The Wasp", timeDiscover: "2009", type: "b", date: DateTime.now()),

  ];

  List<Planet> getTransaction(){
    return transaction;
  }

  void addTransaction(Planet statement){
    transaction.add(statement);
  }
}