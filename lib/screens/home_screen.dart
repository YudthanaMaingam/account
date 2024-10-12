import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project/models/planet_detail.dart';
import 'package:project/providers/planet_provider.dart';
import 'package:project/screens/edit_screen.dart';
import 'package:project/database/planet_database.dart';
// import 'package:project/screens/form_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // void initState(){
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<PlanetProvider>(context, listen: false).initData();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "Planet",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                icon: const Icon(Icons.exit_to_app_outlined))
          ],
        ),
        body: Consumer(
          builder: (context, PlanetProvider provider, Widget? child) {
            if(provider.planetList.isEmpty){
              return const Center(
                child: Text("ไม่พบข้อมูลดวงดาว", style: TextStyle(fontSize: 20),),
              );
            } else {
              return ListView.builder(
                itemCount: provider.planetList.length,
                itemBuilder: (context, int index) {
                  Planet data = provider.planetList[index];
                  return Card(
                    color: (data.type.color),
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        child: FittedBox(
                          child: Text(data.type.title)
                        ),
                      ),
                      title: Text(data.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ผู้ค้นพบ:  ${data.discover}"),
                          Text("เวลาที่ค้นพบ: ค.ศ. ${data.timeDiscover}"),
                          Text("ชนิด: ${data.type.title}"),
                          Text("บันทึกเมื่อ: ${DateFormat("dd/MM/yyyy hh:mm:ss").format(data.date)}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: (){
                          provider.deletePlanet(data.keyID); // ตรวจสอบว่าค่า data.keyID ไม่เป็น null
                        },
                        ),
                        onTap: (){
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context){
                              return EditScreen(editstatement: data);
                            }));
                        },
                    ),
                  );
                });
            }
          },
        ));
  }
}