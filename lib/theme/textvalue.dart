
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Text_Value extends StatelessWidget {
  const Text_Value({super.key, required this.data});
  final  data;
  @override
  Widget build(BuildContext context) {
    return Text(
        data,
      style: TextStyle(
        color: Colors.greenAccent,
        fontWeight: FontWeight.bold
      ),
    );
  }
}

class Text_title extends StatelessWidget {
  const Text_title({super.key, required this.data});
  final  data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: Colors.white,
      ),
    );
  }
}