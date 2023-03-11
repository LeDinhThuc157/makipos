import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:html';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:universal_io/io.dart';

import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import '../network/network_resquest.dart';
import '../theme/colors.dart';
import '../theme/textvalue.dart';
import '../widgets/custom_appbar.dart';
import 'home.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key ? key,
    required this.token, this.id,
  }

  ):super(key: key);

  final String token;
  final String? id;

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  var cell_1_vol;
  var cell_2_vol;
  var cell_3_vol;
  var cell_4_vol;
  var cell_5_vol;
  var cell_6_vol;
  var cell_7_vol;
  var cell_8_vol;
  var cell_9_vol;
  var cell_10_vol;
  var cell_11_vol;
  var cell_12_vol;
  var cell_13_vol;

  var charge;
  bool charbool = true;
  var discharge;
  bool dischabool = true;
  var balance;
  bool balancebool = true;

  Boolvalue() {
    if (charge == "1") {
      charbool = true;
    }
    if (charge == "0") {
      charbool = false;
    }
    if (discharge == "1") {
      dischabool = true;
    }
    if (discharge == "0") {
      dischabool = false;
    }
    if (balance == "0") {
      balancebool = false;
    }
    if (balance == "1") {
      balancebool = true;
    }
  }

  var bat_vol;
  var bat_cap;
  var bat_capacity;
  var bat_temp;
  var bat_percent;
  var bat_cycles;
  var box_temp;
  var system_working_time;
  var bat_current;
  var mos_temp;

  var ave_cell;
  var cell_diff;
  List cells_vol = [];

  postData() async {

    // print("Now: ${DateFormat.Hms().format(DateTime.now())}");
    try {
      String? id = widget.id;

      //4.Thông tin thiết bị.
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id"),
        headers: {"Authorization": widget.token.toString()},
      );
      // await Future.delayed(Duration(milliseconds: 10000), (){
      //   setState(() {
      //   });
      // });
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      cells_vol = userMap["propertiesValue"]["cells_vol"];
      bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
      bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
      bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
      bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
      bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
      bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
      box_temp = userMap["propertiesValue"]["box_temp"].toString();
      system_working_time =
          userMap["propertiesValue"]["logger_status"].toString();
      charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
      discharge =
          userMap["propertiesValue"]["discharge_mos_switch"].toString();
      balance =
          userMap["propertiesValue"]["active_equalization_switch"].toString();
      mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
      bat_current =
          (int.parse(userMap["propertiesValue"]["bat_current"].toString()) *
              0.01)
              .toString();
      var min = cells_vol[0];
      var max = cells_vol[0];
      var sum = cells_vol.reduce((value, current) => value + current);
      for (var i = 0; i < cells_vol.length; i++) {
        // Calculate sum
        // sum += cells_vol[i];
        // Checking for largest value in the list
        if (cells_vol[i] > max) {
          max = cells_vol[i];
        }
        // Checking for smallest value in the list
        if (cells_vol[i] < min) {
          min = cells_vol[i];
        }
      }
      cell_diff = ((max - min)*0.001).toStringAsFixed(4);
      ave_cell = (sum / (cells_vol.length)).toStringAsFixed(4);
      // print("SUM: $sum Min: $min Max: $max Diff: $cell_diff ave: $ave_cell ");
      // print(cells_vol);
    } catch (e) {
      print(e);
    }
    Boolvalue();

  }

  @override
  Widget build(BuildContext context) {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    postData();
    return Scaffold(
      appBar: CustomAppbar(widget.token.toString()),
      backgroundColor: Colors.black45,
      body: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 5)).asyncMap((event) => postData()),
        builder: (context, snapshot) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5 * heightR,
              ),
              Container(
                height: 50 * heightR,
                // width: 2400 * heightR,
                // padding:
                //     EdgeInsets.only(left: 300 * heightR, right: 300 * heightR),
                color: mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(),
                    Container(
                      child: charbool
                          ? Text(
                        'Charge: ON',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 24 * heightR,
                        ),
                      )
                          : Text(
                        'Charge: OFF',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 24 * heightR,
                        ),
                      ),
                    ),
                    Container(
                      child: dischabool
                          ? Text(
                        'Discharge: ON',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 24 * heightR,
                        ),
                      )
                          : Text(
                        'Discharge: OFF',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 24 * heightR,
                        ),
                      ),
                    ),
                    Container(
                      child: balancebool
                          ? Text(
                        'Balance: ON',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 24 * heightR,
                        ),
                      )
                          : Text(
                        'Balance: OFF',
                        style: TextStyle(
                          color: secondary,
                          fontSize: 24 * heightR,
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 5 * heightR,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black54),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Container(
                      child: Text(
                        "$bat_vol mV",
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: 30*heightR,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text_title(data: 'MOS Temp:'),
                              Text_title(data: 'Battery Capacity:'),
                              Text_title(data: 'Cycle Capacity:'),
                              Text_title(data: 'Ave. Cell Volt:'),
                              Text_title(data: 'Battery T2:'),
                            ],
                          ),
                          // SizedBox(
                          //   width: 5 * heightR,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text_Value(
                                data: '$mos_temp°C',
                              ),
                              Text_Value(data: '$bat_cap AH'),
                              Text_Value(data: '$bat_capacity AH'),
                              Text_Value(data: '$ave_cell V'),
                              Text_Value(data: '$bat_temp °C'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text_title(data: 'Remain Battery:'),
                              // Text_title(
                              //     data:'Remain Capacity(Khong co):'
                              // ),
                              Text_title(data: 'Cycle Count:'),
                              Text_title(data: 'Cell Volt.Diff:'),
                              Text_title(data: 'Battery T1:'),
                              // Text_title(
                              //     data:'Battery T3(Khoong co):'
                              // ),
                              // Text_title(
                              //     data:'Heating Status(Khong co):'
                              // ),
                              // Text_title(
                              //     data:'Charg.Plugged(Khong co):'
                              // ),
                              Text_title(data: 'Time Emerg:'),
                            ],
                          ),
                          // SizedBox(
                          //   width: 5 * heightR,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text_Value(
                                data: '$bat_percent%',
                              ),
                              // Text_Value(
                              //     data:'396.0AH'
                              // ),
                              Text_Value(data: '$bat_cycles'),
                              Text_Value(data: '$cell_diff V'),
                              Text_Value(data: '$box_temp°C'),
                              // Text_Value(
                              //     data:'23.5°C'
                              // ),
                              // Text_Value(
                              //     data:'OFF'
                              // ),
                              // Text_Value(
                              //     data:'Plugged'
                              // ),
                              Text_Value(data: '$system_working_time'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        '$bat_current A',
                        style: TextStyle(
                          color: Colors.greenAccent[400],
                          fontSize: 30 *heightR,
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 20*heightR,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 230 * heightR,
                      alignment: Alignment.center,
                      child: Text(
                        "Cells Voltage",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                          fontSize: 36 * heightR,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20*heightR,
                    ),
                    Container(
                      height: 600 * heightR,
                      width: 1200 * heightR,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.builder(
                          itemCount: cells_vol.length ~/ 2,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 40 * heightR,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "${2*index}",
                                        style: TextStyle(
                                            color: secondary,
                                            fontSize: 25*heightR
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 60 * heightR,
                                      alignment: Alignment.center,
                                    ),
                                    SizedBox(
                                      width: 10 * heightR,
                                    ),
                                    Text(
                                      "${cells_vol[2*index]} mV",
                                      style: TextStyle(
                                          color: green,
                                          fontSize: 25*heightR
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80 * heightR,
                                    ),
                                    Container(
                                      child: Text(
                                        "${2*index + 1}",
                                        style: TextStyle(
                                            color: secondary,
                                            fontSize: 25*heightR
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 60 * heightR,
                                      alignment: Alignment.center,
                                    ),
                                    SizedBox(
                                      width: 10 * heightR,
                                    ),
                                    Text(
                                      "${cells_vol[2*index+1]} mV",
                                      style: TextStyle(
                                          color: green,
                                          fontSize: 25*heightR
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     _makePostRequest(url);
              //     // do something
              //   },
              //   icon: Icon(
              //     Icons.menu,
              //     color: secondary,
              //   ),
              // ),
            ],
          ),
        ),
      ) //Center
    );
  }
}

