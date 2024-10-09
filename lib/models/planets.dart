import 'package:flutter/material.dart';

enum Type {
  bType(title:"b", color: Colors.orange),
  dType(title:"d", color: Colors.purple),
  cType(title: "c", color: Colors.green);

  const Type({required this.title, required this.color});
  final String title;
  final Color color;

}

class Planets {

  Planets ({required this.name, required this.discover, required this.time, required this.planetType});

  String name;
  String discover;
  String time;
  Type planetType;
}

List<Planets> data = [
  Planets(name: "WASP-1", discover: "null", time: "2006", planetType: Type.bType),
  Planets(name: "WASP-18", discover: "null", time: "2009", planetType: Type.bType),
];