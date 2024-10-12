import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:project/models/planet_detail.dart';
import 'package:project/providers/planet_provider.dart';
import 'package:project/screens/form_screen.dart';
import 'package:project/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) {
        return PlanetProvider();
      })],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'Planet'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override

  void initState(){
    // TODO: implement initState
    super.initState();
    Provider.of<PlanetProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body:TabBarView(
          children: [
            HomeScreen(),
            FormScreen()
          ]) ,
          bottomNavigationBar: TabBar(
            tabs:[
              Tab(
                icon: Icon(Icons.list_alt_outlined),
                text: "รายการดวงดาว"
                ),
              Tab(
                icon: Icon(Icons.add_box_outlined),
                text: "เพิ่มดวงดาว"
                )
            ]),
          ),
          );
  }
}
