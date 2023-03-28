import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';



class EmptyPage extends StatefulWidget {

  @override
  _EmptyPageState createState() => _EmptyPageState();
}
class _EmptyPageState extends State<EmptyPage> {
  var ListID;
  final Storage _localStorage = window.localStorage;
  List<String> cell = [];
  Future<List?> _LisdDevice() async => ListID = _localStorage['List_Device']!.split(",");
  Future<List?> _ListCell() async => cell = _localStorage['List_Cell']!.split(",");
  var _Cell;
  LoadData(){
    _LisdDevice();
    _ListCell();
    var cell1 = cell.toString();
    cell1 = cell1.substring(2,cell1.length-2);
    _Cell = cell1.split(",");
    print(_Cell);
    // print("List ${ListID.runtimeType} \n $ListID \n Cel_vol $cell");
  }
  @override
  Widget build(BuildContext context) {
    LoadData();
    return SingleChildScrollView(
      child: Container(
          child: Column(
            children: [
              Center(
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.only(top: 60),
                    padding:  EdgeInsets.fromLTRB(60, 0, 60, 0),
                    child: ElevatedButton(
                        onPressed: (){
                          LoadData();
                        },
                        child: Text("Load")
                    ),
                  )

              ),
              Container(
                height: 600 ,
                width: 1200 ,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                    itemCount: _Cell.length ~/ 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 40 ,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "${2*index}",
                                  style: TextStyle(
                                      color: secondary,
                                      fontSize: 25
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 60 ,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                width: 10 ,
                              ),
                              Text(
                                "${_Cell[2*index]} mV",
                                style: TextStyle(
                                    color: green,
                                    fontSize: 25
                                ),
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Container(
                                child: Text(
                                  "${2*index + 1}",
                                  style: TextStyle(
                                      color: secondary,
                                      fontSize: 25
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 60 ,
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${_Cell[2*index+1]} mV",
                                style: TextStyle(
                                    color: green,
                                    fontSize: 25
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),

            ],
          )

      ),
    );
  }

}
