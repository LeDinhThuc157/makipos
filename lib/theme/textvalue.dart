
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Text_Value extends StatelessWidget {
  const Text_Value({super.key, required this.data});
  final  data;
  @override
  Widget build(BuildContext context) {
    double heightR;
    heightR = MediaQuery.of(context).size.height / 1080;
    return Text(
        data,
      style: TextStyle(
        color: Colors.greenAccent,
        fontWeight: FontWeight.bold,
        fontSize: 24*heightR,
      ),
    );
  }
}

class Text_title extends StatelessWidget {
  const Text_title({super.key, required this.data});
  final  data;

  @override
  Widget build(BuildContext context) {
    double heightR;
    heightR = MediaQuery.of(context).size.height / 1080;
    return Text(
      data,
      style: TextStyle(
          color: Colors.white,
        fontSize: 24 * heightR,
      ),
    );
  }
}