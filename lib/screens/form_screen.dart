import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/screens/home_screen.dart';
import 'package:account/screens/homeplanet.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:account/models/planets.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _discover = '';
  String _time = '';
  Type _type = Type.bType;

  // final titleController = TextEditingController();

  // final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            'เพิ่มดาวเคราะห์',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อดาวเคราะห์',
                  ),
                  // autofocus: false,
                  // controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ผู้ค้นพบ',
                  ),
                  // autofocus: false,
                  // controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกผู้ค้นพบ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _discover = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'เวลาที่ค้นพบ(ค.ศ.)',
                  ),
                  // autofocus: false,
                  // controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกเวลาที่ค้นพบ(ค.ศ.)';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _time = value!;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    value: _type,
                    decoration: const InputDecoration(
                        label: Text(
                      "ชนิด",
                      style: TextStyle(fontSize: 15),
                    )),
                    items: Type.values.map((key) {
                      return DropdownMenuItem(
                        value: key,
                        child: Text(key.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _type = value!;
                      });
                    }),
                FilledButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      _formKey.currentState!.save();
                      data.add(Planets(
                          name: _name,
                          discover: _discover,
                          time: _time,
                          planetType: _type));
                      _formKey.currentState!.reset();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const MyHomePage()));
                    },
                    style:
                        FilledButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      "บันทึก",
                      style: TextStyle(fontSize: 20),
                    )),
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const MyHomePage()));
                  },
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "ยกเลิก",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )));
  }
}
