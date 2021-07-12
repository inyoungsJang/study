import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_dubhe/src/device_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Balsamiq_Sans',
        primarySwatch: Colors.amber,
      ),
      home: NewDubhe(),
    );
  }
}

class NewDubhe extends StatefulWidget {
  @override
  _NewDubheState createState() => _NewDubheState();
}

class _NewDubheState extends State<NewDubhe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: DeviceInfo(),
        //height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
