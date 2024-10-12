import 'package:flutter/material.dart';

enum Type {
  bType(title:"b", color: Color.fromARGB(255, 240, 196, 131)),
  dType(title:"d", color: Color.fromARGB(255, 242, 168, 255)),
  cType(title: "c", color: Color.fromARGB(255, 248, 135, 135)),
  noneType(title: "None", color: Color.fromARGB(255, 255, 0, 0));
  

  const Type({required this.title, required this.color});
  final String title;
  final Color color;

}

class Planet {
  int? keyID;
  String name; // ชื่อดาว
  String discover; // ผู้ค้นพบ
  String timeDiscover; // ปีที่ค้นพบ
  Type type; // ชนิด
  DateTime date; // วันเวลาที่บันทุึก

  Planet({this.keyID,required this.name, required this.discover, required this.timeDiscover, required this.type, required this.date});
}