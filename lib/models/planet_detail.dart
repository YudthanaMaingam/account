class Planet {
  String name; // ชื่อดาว
  String discover; // ผู้ค้นพบ
  String timeDiscover; // ปีที่ค้นพบ
  String type; // ชนิด
  DateTime date; // วันเวลาที่บันทุึก

  Planet({required this.name, required this.discover, required this.timeDiscover, required this.type, required this.date});
}