import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/models/planet_detail.dart';
import 'package:project/providers/planet_provider.dart';
// import 'package:project/screens/home_screen.dart';
import 'package:provider/provider.dart';
// import 'package:project/main.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {

  Planet editstatement;

  EditScreen({super.key, required this.editstatement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final discoverController = TextEditingController();
  final timeController = TextEditingController();

  Type? _selectedType;

  @override
  Widget build(BuildContext context) {

@override
void initState() {
  super.initState();
  
  // ตั้งค่าตัวควบคุมใน initState
  titleController.text = widget.editstatement.name;
  discoverController.text = widget.editstatement.discover;
  timeController.text = widget.editstatement.timeDiscover;
  _selectedType = widget.editstatement.type;
}

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "แก้ไขดวงดาว",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "ชื่อดาวเคราะห์"),
                  controller: titleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return "กรุณาป้อนข้อมูล";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "ผู้ค้นพบ"),
                  controller: discoverController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return "กรุณาป้อนข้อมูล";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "เวลาที่ค้นพบ(ค.ศ.)"),
                  keyboardType: TextInputType.number,
                  controller: timeController,
                  validator: (String? time) {
                    if (time!.isEmpty) {
                      return "กรุณาป้อนข้อมูล";
                    }
                    if (int.parse(time) <= 0) {
                      return "กรุณาป้อนปี ค.ศ.";
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<Type>(
                  decoration: const InputDecoration(labelText: "ชนิด"),
                  value: _selectedType,
                  items: Type.values.map((Type type) {
                    return DropdownMenuItem<Type>(
                      value: type,
                      child: Text(type.title),  // แสดงชนิดของดาวเคราะห์
                    );
                  }).toList(),
                  onChanged: (Type? newValue) {
                    setState(() {
                      _selectedType = newValue;  // อัปเดตค่าที่เลือก
                    });
                  },
                  validator: (value) => value == null ? 'กรุณาเลือกชนิด' : null,
                ),

                const SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: () {
                     if (formKey.currentState!.validate()) {
                        // สร้าง object ของ Planet
                        var statement = Planet(
                          keyID: widget.editstatement.keyID,
                          name: titleController.text,
                          discover: discoverController.text,
                          timeDiscover: timeController.text,
                          type: _selectedType!,  // ใช้ค่าที่เลือกจาก enum
                          date: DateTime.now(),
                        );
                        print('Updating Planet: ${statement.toString()}'); // ดูค่าที่กำลังจะถูกอัปเดต
                        //เรียก provider
                        var provider = Provider.of<PlanetProvider>(context,listen:false);
                        
                        provider.updatePlanet(statement);

                        
                        Navigator.push(context, MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context){
                          return const MyHomePage(title: '',);
                        }));
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 138, 68),
                      textStyle: const TextStyle(fontSize: 20,)
                    ),
                    child: const Text("แก้ไข"))
              ],
            )),
      ),
    );
  }
}