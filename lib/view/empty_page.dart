import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/custom_appbar.dart';



class EmptyPage extends StatefulWidget {

  @override
  _EmptyPageState createState() => _EmptyPageState();
}
class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Demo'),
        actions: [
          Icon(Icons.icecream)
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white60,
        child: DrawerPage(),
      ),
    );
  }

}
