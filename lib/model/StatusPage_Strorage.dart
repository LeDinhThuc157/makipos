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

class StatusPage extends StatefulWidget {
  const StatusPage({Key ? key,
    required this.token, this.id, required this.user, required this.password,
  }

      ):super(key: key);

  final String token;
  final String? id;
  final String user;
  final String password;
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  // dữ liệu p1
  var charge;
  bool charbool = true;
  var discharge;
  bool dischabool = true;
  var balance;
  bool balancebool = true;

  // dữ liệu p2
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
  var list_cell;
  var cell_1;

  @override
  void initState(){
    super.initState();
    _Read();
  }
  final Storage _localStorage = window.localStorage;

  Future<String?> _charge() async => charge = _localStorage['charging_mos_switch'];
  Future<String?> _discharge() async => discharge = _localStorage['discharge_mos_switch'];
  Future<String?> _balance() async => balance = _localStorage['active_equalization_switch'];
  Future<String?> _bat_vol() async => bat_vol = _localStorage['bat_vol'];
  Future<String?> _bat_cap() async => bat_cap = _localStorage['bat_cap'];

  Future<String?> _bat_capacity() async => bat_capacity = _localStorage['bat_capacity'];
  Future<String?> _bat_temp() async => bat_temp = _localStorage['bat_temp'];
  Future<String?> _bat_percent() async => bat_percent = _localStorage['bat_percent'];
  Future<String?> _bat_cycles() async => bat_cycles = _localStorage['bat_cycles'];
  Future<String?> _box_temp() async => box_temp = _localStorage['box_temp'];
  Future<String?> _logger_status() async => system_working_time = _localStorage['logger_status'];
  Future<String?> _tube_temp() async => mos_temp = _localStorage['tube_temp'];
  Future<String?> _bat_current() async => bat_current = _localStorage['bat_current'];
  Future<String?> _cell_diff() async => cell_diff = _localStorage['cell_diff'];
  Future<String?> _ave_cell() async => ave_cell = _localStorage['ave_cell'];

  // Future<String?> _cells_vol() async => list_cell = _localStorage['cells_vol'];

  void _Read(){
    _charge();_discharge();_balance();
    _bat_vol();_bat_cap();_bat_capacity();
    _bat_temp();_bat_percent();_bat_cycles();
    _box_temp();_logger_status();_tube_temp();
    _bat_current();_cell_diff();_ave_cell();
    // _cells_vol();
    // cell_1 = List<String>.from(json.decode(list_cell));
    // List<String> stringList = List<String>.from(json.decode(list_cell));
    // print("$list_cell \n ${list_cell.runtimeType} \n");
    Boolvalue();
  }
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

  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }
  // Future saveList(List data, String propertyCode) async {
  //   _localStorage['$propertyCode'] = data.toString();
  // }
  postData() async {
    try {
      String? id = widget.id;
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id"),
        headers: {"Authorization": widget.token.toString()},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);

      cells_vol = userMap["propertiesValue"]["cells_vol"];
      // saveList(userMap["propertiesValue"]["cells_vol"], "cells_vol");
      // bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
      save(userMap["propertiesValue"]["bat_vol"].toString(), "bat_vol");
      // bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
      save(userMap["propertiesValue"]["bat_cap"].toString(), "bat_cap");
      // bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
      save(userMap["propertiesValue"]["bat_capacity"].toString(), "bat_capacity");
      // bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
      save(userMap["propertiesValue"]["bat_temp"].toString(), "bat_temp");
      // bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
      save(userMap["propertiesValue"]["bat_percent"].toString(), "bat_percent");
      // bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
      save(userMap["propertiesValue"]["bat_cycles"].toString(), "bat_cycles");
      // box_temp = userMap["propertiesValue"]["box_temp"].toString();
      save(userMap["propertiesValue"]["box_temp"].toString(), "box_temp");
      // system_working_time = userMap["propertiesValue"]["logger_status"].toString();
      save(userMap["propertiesValue"]["logger_status"].toString(), "logger_status");
      save(userMap["propertiesValue"]["tube_temp"].toString(), "tube_temp");

      save(userMap["propertiesValue"]["charging_mos_switch"].toString(), "charging_mos_switch");
      save(userMap["propertiesValue"]["discharge_mos_switch"].toString(), "discharge_mos_switch");
      save(userMap["propertiesValue"]["active_equalization_switch"].toString(), "active_equalization_switch");
      // charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
      // discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
      // balance = userMap["propertiesValue"]["active_equalization_switch"].toString();
      // mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
      // bat_current = (int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString();
      save((int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString(), "bat_current");
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
      // cell_diff = ((max - min)*0.001).toStringAsFixed(4);
      save(((max - min)*0.001).toStringAsFixed(4), "cell_diff");
      // ave_cell = (sum / (cells_vol.length)).toStringAsFixed(2);
      save((sum / (cells_vol.length)).toStringAsFixed(2), "ave_cell");

      // Setting data

      // _cellOVP = userMap["propertiesValue"]["single_overvoltage"].toString();
      save(userMap["propertiesValue"]["single_overvoltage"].toString(), "single_overvoltage");
      // _cellOVPR = userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString();
      save(userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString(), "monomer_overvoltage_recovery");
      // _cellUVPR = userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString();
      save(userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString(), "discharge_overcurrent_protection_value");
      // _cellUVP = userMap["propertiesValue"]["differential_voltage_protection_value"].toString();
      save(userMap["propertiesValue"]["differential_voltage_protection_value"].toString(), "differential_voltage_protection_value");
      // _continuedChargeCurr = userMap["propertiesValue"]["equalizing_opening_differential"].toString();
      save(userMap["propertiesValue"]["equalizing_opening_differential"].toString(), "equalizing_opening_differential");
      // _continuedDischargeCurr = userMap["propertiesValue"]["charging_overcurrent_delay"].toString();
      save(userMap["propertiesValue"]["charging_overcurrent_delay"].toString(), "charging_overcurrent_delay");
      // _dischargeOCPdelay = userMap["propertiesValue"]["equalizing_starting_voltage"].toString();
      save(userMap["propertiesValue"]["equalizing_starting_voltage"].toString(), "equalizing_starting_voltage");
      // _chargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString();
      save(userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString(), "high_temp_protect_bat_charge");
      // _dischargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString();
      save(userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString(), "high_temp_protect_bat_discharge");
      // _chargeUTP = userMap["propertiesValue"]["charge_cryo_protect"].toString();
      save(userMap["propertiesValue"]["charge_cryo_protect"].toString(), "charge_cryo_protect");
      // _chargeUTPR =  userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString();
      save(userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString(), "recover_val_charge_cryoprotect");
      // _startBalanceVolt = userMap["propertiesValue"]["tube_temp_protection"].toString();
      save(userMap["propertiesValue"]["tube_temp_protection"].toString(), "tube_temp_protection");
      // _cellcount = userMap["propertiesValue"]["strings_settings"].toString();
      save(userMap["propertiesValue"]["strings_settings"].toString(), "strings_settings");
      // _batterycapacity = userMap["propertiesValue"]["battery_capacity_settings"].toString();
      save(userMap["propertiesValue"]["battery_capacity_settings"].toString(), "battery_capacity_settings");

    } catch (e) {
      print(e);
    }
    // Boolvalue();

  }

  @override
  Widget build(BuildContext context) {

    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    postData();
    return Scaffold(
        appBar: CustomAppbar(),
        backgroundColor: Colors.black45,
        body:
        StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 3)).asyncMap((event) => _Read()).take(2),
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

