
import 'package:flutter/material.dart';
import 'package:makipos/view/StatusPage.dart';
import 'package:makipos/view/login.dart';
import 'view/home.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(""),
    );
  }
}
