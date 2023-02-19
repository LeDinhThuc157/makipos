import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:universal_io/io.dart';

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:retry/retry.dart';
import '../network/network_resquest.dart';
import '../theme/colors.dart';
import '../theme/textvalue.dart';
import '../widgets/custom_appbar.dart';

class MymobileBodySTT extends StatefulWidget {
  const MymobileBodySTT(this._token,);
  final String _token;
  @override
  _MymobileBodySTTState createState() => _MymobileBodySTTState();
}
class _MymobileBodySTTState extends State<MymobileBodySTT> {
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

  List cells_vol = [];
  String id = "63be79a13ea8bc0007797118";

  postData() async {
    try {
      //4.Thông tin thiết bị.

      var responseGet_Listdevice = await http.get(
        Uri.parse("https://smarthome.test.makipos.net:3029/devices/$id"),
        headers: {"Authorization": widget._token.toString()},
      );
      print("StatusListDevice: ${responseGet_Listdevice.statusCode}");
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      // print("Time: ${userMap["propertiesValue"]["cells_vol"]}");

      setState(() {
        cells_vol = userMap["propertiesValue"]["cells_vol"];
        cell_1_vol = userMap["propertiesValue"]["cell_1_vol"].toString();
        cell_2_vol = userMap["propertiesValue"]["cell_2_vol"].toString();
        cell_3_vol = userMap["propertiesValue"]["cell_3_vol"].toString();
        cell_4_vol = userMap["propertiesValue"]["cell_4_vol"].toString();
        cell_5_vol = userMap["propertiesValue"]["cell_5_vol"].toString();
        cell_6_vol = userMap["propertiesValue"]["cell_6_vol"].toString();
        cell_7_vol = userMap["propertiesValue"]["cell_7_vol"].toString();
        cell_8_vol = userMap["propertiesValue"]["cell_8_vol"].toString();
        cell_9_vol = userMap["propertiesValue"]["cell_9_vol"].toString();
        cell_10_vol = userMap["propertiesValue"]["cell_10_vol"].toString();
        cell_11_vol = userMap["propertiesValue"]["cell_11_vol"].toString();
        cell_12_vol = userMap["propertiesValue"]["cell_12_vol"].toString();
        cell_13_vol = userMap["propertiesValue"]["cell_13_vol"].toString();

        bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
        bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
        bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
        bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
        bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
        bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
        box_temp = userMap["propertiesValue"]["box_temp"].toString();
        system_working_time =
            userMap["propertiesValue"]["system_working_time"].toString();
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
      });
      print(cells_vol);
    } catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    postData();
    Boolvalue();
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5 * heightR,
            ),
            Container(
              height: 150*heightR,
              color: mainColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5*heightR,),
                  Container(
                    child: charbool
                        ? Text(
                      'Charge: ON',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 24 * heightR,
                      ),
                      textAlign: TextAlign.center,
                    )
                        : Text(
                      'Charge: OFF',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 24 * heightR,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //SizedBox(height: 5*heightR,),
                  Container(
                    child: dischabool
                        ? Text(
                      'Discharge: ON',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 24 * heightR,
                      ),
                      textAlign: TextAlign.center,
                    )
                        : Text(
                      'Discharge: OFF',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 24 * heightR,
                      ),
                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
                    )
                        : Text(
                      'Balance: OFF',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 24 * heightR,
                      ),
                      textAlign: TextAlign.center,
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
                  color: Colors.black54
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "$bat_vol mV",
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 60*heightR,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.greenAccent,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Container(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text_title(data: 'MOS Temp:'),
                                  Text_title(data: 'Battery Capacity:'),
                                  Text_title(data: 'Cycle Capacity:'),
                                  Text_title(data: 'Ave. Cell Volt(Chưa có):'),
                                  Text_title(data: 'Battery T2:'),
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
                              SizedBox(
                                width: 5 * heightR,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text_Value(
                                    data: '$mos_temp°C',
                                  ),
                                  Text_Value(data: '$bat_cap AH'),
                                  Text_Value(data: '$bat_capacity AH'),
                                  Text_Value(data: '3.384V'),
                                  Text_Value(data: '$bat_temp °C'),
                                  Text_Value(
                                    data: '$bat_percent%',
                                  ),
                                  // Text_Value(
                                  //     data:'396.0AH'
                                  // ),
                                  Text_Value(data: '$bat_cycles'),
                                  Text_Value(data: '0.002V'),
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
                        SizedBox(),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      '$bat_current A',
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 60 *heightR,
                      ),
                    ),
                  ),
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
                    width: 250 * heightR,
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
                    color: Colors.black54,
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
          ],
        ),
      ),

    );

  }
}


class  MymobileBodySTS extends StatefulWidget {
  const MymobileBodySTS(
      this._token,
      );
  final String _token;
  @override
  _MymobileBodySTSState createState() => _MymobileBodySTSState();
}

class _MymobileBodySTSState extends State<MymobileBodySTS> {

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

  // Basic setting text
  TextEditingController  cellcount = TextEditingController();
  var _cellcount;
  TextEditingController batterycapacity = TextEditingController();
  var _batterycapacity;

  String id = "63be79a13ea8bc0007797118";
  // Advance Settings
  TextEditingController cellOVP = TextEditingController();
  TextEditingController cellOVPR = TextEditingController();
  TextEditingController cellUVPR = TextEditingController();
  TextEditingController cellUVP = TextEditingController();
  TextEditingController continuedChargeCurr = TextEditingController();
  TextEditingController continuedDischargeCurr = TextEditingController();
  TextEditingController dischargeOCPdelay = TextEditingController();
  TextEditingController chargeOTP = TextEditingController();
  TextEditingController dischargeOTP = TextEditingController();
  TextEditingController chargeUTP = TextEditingController();
  TextEditingController chargeUTPR = TextEditingController();
  TextEditingController startBalanceVolt = TextEditingController();

  var _calibratingVolt;
  var _calibratingCurr;
  var _cellOVP;
  var _cellOVPR;
  var _cellUVPR;
  var _cellUVP;
  var _continuedChargeCurr;
  var _continuedDischargeCurr;
  var _dischargeOCPdelay;
  var _chargeOTP;
  var _dischargeOTP;
  var _chargeUTP;
  var _chargeUTPR;
  var _startBalanceVolt;

  postData() async {
    try {
      //4.Thông tin thiết bị.

      var responseGet_Listdevice = await http.get(
        Uri.parse("https://smarthome.test.makipos.net:3029/devices/$id"),
        headers: {"Authorization": widget._token.toString()},
      );
      print("StatusListDevice: ${responseGet_Listdevice.statusCode}");
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      // print("Time: ${userMap["propertiesValue"]["cells_vol"]}");

      setState(() {
        _calibratingVolt = userMap["propertiesValue"]["bat_vol"].toString();
        _calibratingCurr = userMap["propertiesValue"]["bat_current"].toString();
        _cellOVP = userMap["propertiesValue"]["single_overvoltage"].toString();
        _cellOVPR = userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString();
        _cellUVPR = userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString();
        _cellUVP = userMap["propertiesValue"]["differential_voltage_protection_value"].toString();
        _continuedChargeCurr = userMap["propertiesValue"]["equalizing_opening_differential"].toString();
        _continuedDischargeCurr = userMap["propertiesValue"]["charging_overcurrent_delay"].toString();
        _dischargeOCPdelay = userMap["propertiesValue"]["equalizing_starting_voltage"].toString();
        _chargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString();
        _dischargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString();
        _chargeUTP = userMap["propertiesValue"]["charge_cryo_protect"].toString();
        _chargeUTPR =  userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString();
        _startBalanceVolt = userMap["propertiesValue"]["tube_temp_protection"].toString();
        _cellcount = userMap["propertiesValue"]["strings_settings"].toString();
        _batterycapacity = userMap["propertiesValue"]["battery_capacity_settings"].toString();
        //Status
        cells_vol = userMap["propertiesValue"]["cells_vol"];
        bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
        bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
        bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
        bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
        bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
        bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
        box_temp = userMap["propertiesValue"]["box_temp"].toString();
        system_working_time =
            userMap["propertiesValue"]["system_working_time"].toString();
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
        cell_diff = (max - min)*0.001;
        ave_cell = sum / (cells_vol.length);
        print("SUM: $sum Min: $min Max: $max Diff: $cell_diff ave: $ave_cell");
      });
      print(cells_vol);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    final _height_1 = 40*heightR;
    postData();
    // postDataSetting(id,"single_overvoltage",4200);
    // postDataSetting(id,"single_overvoltage",4200);
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5*heightR,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black54
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "$bat_vol mV",
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 60*heightR,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.greenAccent,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Container(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text_title(data: 'MOS Temp:'),
                                  Text_title(data: 'Battery Capacity:'),
                                  Text_title(data: 'Cycle Capacity:'),
                                  Text_title(data: 'Ave. Cell Volt(Chưa có):'),
                                  Text_title(data: 'Battery T2:'),
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
                              SizedBox(
                                width: 5 * heightR,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text_Value(
                                    data: '$mos_temp°C',
                                  ),
                                  Text_Value(data: '$bat_cap AH'),
                                  Text_Value(data: '$bat_capacity AH'),
                                  Text_Value(data: '3.384V'),
                                  Text_Value(data: '$bat_temp °C'),
                                  Text_Value(
                                    data: '$bat_percent%',
                                  ),
                                  // Text_Value(
                                  //     data:'396.0AH'
                                  // ),
                                  Text_Value(data: '$bat_cycles'),
                                  Text_Value(data: '0.002V'),
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
                        SizedBox(),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      '$bat_current A',
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 60 *heightR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20*heightR,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 250 * heightR,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 5*heightR,bottom: 5*heightR),
                    child: Text(
                      "Basic Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                        fontSize: 30*heightR,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20*heightR,
                  ),
                  Container(
                    width: 1200 * heightR,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Cell Count:"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Battery Capacity(AH):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Calibrating Volt.(mA):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Calibrating Curr.(A):"),
                            ),
                            SizedBox(height: 20*heightR,),
                          ],
                        ),
                        SizedBox(
                          width: 20*heightR,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                obscureText: false,
                                decoration:  InputDecoration(
                                    labelText: "$_cellcount",
                                    labelStyle: TextStyle(color: Colors.cyanAccent)
                                ),
                                controller: cellcount,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                obscureText: false,
                                decoration:  InputDecoration(
                                    labelText: "$_batterycapacity",
                                    labelStyle: TextStyle(color: Colors.cyanAccent)
                                ),
                                controller: batterycapacity,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                autocorrect: false,
                                obscureText: false,
                                decoration:  InputDecoration(
                                    labelText: "$_calibratingVolt",
                                    labelStyle: TextStyle(color: Colors.cyanAccent)
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                autocorrect: false,
                                obscureText: false,
                                decoration:  InputDecoration(
                                  labelText: "$_calibratingCurr",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                          ],
                        ),
                        SizedBox(
                          width: 10*heightR,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 20*heightR,),
                            Container(
                                height: _height_1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                                child: TextButton(
                                  child:  Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Cell Count:${int.parse(cellcount.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"single_overvoltage",int.parse(cellcount.text));
                                      },
                                    ).show();
                                  },
                                )
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Battery Capacity:${int.parse(batterycapacity.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"battery_capacity_settings",int.parse(batterycapacity.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                                height: _height_1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black
                                ),
                                child: TextButton(
                                  child:  Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: (){
                                  },
                                )
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20*heightR,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 250 * heightR,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 5*heightR,bottom: 5*heightR),
                    child: Text(
                      "Advance Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                        fontSize: 30*heightR,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20*heightR,
                  ),
                  Container(
                    width: 1200*heightR,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Cell OVP(mV):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Cell OVPR(mV):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Cell UVPR(mV):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Cell UVP(mV):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Continued Charge Curr.(A):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Continued Discharge Curr.(A):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Discharge OCP Delay(S):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Charge OTP(°C):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Discharge OTP(°C):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Charge UTP(°C):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Charge UTPR(°C):"),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              child: Text_title(data:"Start Balance Volt. (mV):"),
                            ),
                            SizedBox(height: 20*heightR,),
                          ],
                        ),
                        SizedBox(
                          width: 20*heightR,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_cellOVP",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: cellOVP,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_cellOVPR",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: cellOVPR,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_cellUVPR",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: cellUVPR,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_cellUVP",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: cellUVP,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_continuedChargeCurr",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: continuedChargeCurr,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_continuedDischargeCurr",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: continuedDischargeCurr,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_dischargeOCPdelay",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: dischargeOCPdelay,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_chargeOTP",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: chargeOTP,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_dischargeOTP",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: dischargeOTP,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_chargeUTP",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: chargeUTP,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_chargeUTPR",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: chargeUTPR,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              width: 260*heightR,
                              height: _height_1,
                              // color: Colors.red,
                              child: TextField(
                                decoration:  InputDecoration(
                                  labelText: "$_startBalanceVolt",
                                  labelStyle: TextStyle(
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                controller: startBalanceVolt,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.cyanAccent),
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                          ],
                        ),
                        SizedBox(
                          width: 10*heightR,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Cell OVP:${int.parse(cellOVP.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"single_overvoltage",int.parse(cellOVP.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Cell OVPR:${int.parse(cellOVPR.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"monomer_overvoltage_recovery",int.parse(cellOVPR.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Cell UVPR:${int.parse(cellUVPR.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"discharge_overcurrent_protection_value",int.parse(cellUVPR.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Cell UVP:${int.parse(cellUVP.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"differential_voltage_protection_value",int.parse(cellUVP.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Continued Charge Curr:${int.parse(continuedChargeCurr.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"equalizing_opening_differential",int.parse(continuedChargeCurr.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Continued Discharge Curr:${int.parse(continuedDischargeCurr.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"charging_overcurrent_delay",int.parse(continuedDischargeCurr.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Discharge OCP Delay:${int.parse(dischargeOCPdelay.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"equalizing_starting_voltage",int.parse(dischargeOCPdelay.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Charge OTP:${int.parse(chargeOTP.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"high_temp_protect_bat_charge",chargeOTP.text);
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Discharge OTP:${int.parse(dischargeOTP.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"high_temp_protect_bat_discharge",int.parse(dischargeOTP.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Charge UTP:${int.parse(chargeUTP.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"charge_cryo_protect",int.parse(chargeUTP.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Charge UTPR:${int.parse(chargeUTPR.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"recover_val_charge_cryoprotect",int.parse(chargeUTPR.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                            Container(
                              height: _height_1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black87
                              ),
                              child: TextButton(
                                  onPressed: (){
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.bottomSlide,
                                      btnCancelText: "No, cancel",
                                      btnOkText: "Yes, continue",
                                      title: 'Continue update!',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                      'Start Balance Volt:${int.parse(startBalanceVolt.text)}',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        postDataSetting(id,"tube_temp_protection",int.parse(startBalanceVolt.text));
                                      },
                                    ).show();
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20*heightR,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), //Center
    );
  }



  postDataSetting(final id,final propertyCode, final value) async{
    print(propertyCode);
    print(value);
    try{
      var response_setting = await http.post(
          Uri.parse(
              "http://smarthome.test.makipos.net:3028/users-control-devices"),
          headers: {
            "Content-type": "application/json",
            "Authorization": widget._token.toString()
          },
          body: jsonEncode(
              {
                "deviceId": id,
                "propertyCode": propertyCode,
                "localId": "1",
                "commandString": "{\"d\":$value}",
                "waitResponse": false,
                "timeout": 100
              }
          )
      );
      print("BodySetting $propertyCode : ${response_setting.statusCode}");
    } catch(e){
      print(e);
    }
  }
}
