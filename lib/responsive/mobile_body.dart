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
import 'package:retry/retry.dart';
import '../network/network_resquest.dart';
import '../theme/colors.dart';
import '../theme/textvalue.dart';
import '../widgets/custom_appbar.dart';

class MymobileBodySTT extends StatefulWidget {
  const MymobileBodySTT();

  @override
  _MymobileBodySTTState createState() => _MymobileBodySTTState();
}
class _MymobileBodySTTState extends State<MymobileBodySTT> {

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
  var uptime;
  var bat_current;
  var mos_temp;

  var ave_cell;
  var cell_diff;
  var last_update;
  var cells_vol = [];
  List<String> cells = [];
  @override
  void initState(){
    super.initState();
    // _Read();
  }
  final Storage _localStorage = window.localStorage;

  Future<List?> _cells() async => cells = _localStorage['List_Cell']!.split(",");
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
  Future<String?> _uptime() async => uptime = _localStorage['uptime'];
  Future<String?> _tube_temp() async => mos_temp = _localStorage['tube_temp'];
  Future<String?> _bat_current() async => bat_current = _localStorage['bat_current'];
  Future<String?> _cell_diff() async => cell_diff = _localStorage['cell_diff'];
  Future<String?> _ave_cell() async => ave_cell = _localStorage['ave_cell'];
  Future<String?> _last_update() async => last_update = _localStorage['logger_status'];



  void _Read(){
    // String
    _charge();_discharge();_balance();
    _bat_vol();_bat_cap();_bat_capacity();
    _bat_temp();_bat_percent();_bat_cycles();
    _box_temp();_uptime();_tube_temp();
    _bat_current();_cell_diff();_ave_cell(); _last_update();
    Boolvalue();
    _ReadList();
  }
  void _ReadList(){
    // List Cells
    _cells();
    var cell1 = cells.toString();
    cell1 = cell1.substring(2,cell1.length-2);
    cells_vol = cell1.split(",");
  }
  @override
  Widget build(BuildContext context) {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    // _Read();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: CustomAppbar(),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white60,
          child: DrawerPage(),
        ),
        backgroundColor: Colors.black45,
        body: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 1)).asyncMap((event) => _Read()),
          builder: (context, snapshot) => SingleChildScrollView(
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
                                      Text_title(data: 'Ave. Cell Volt:'),
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
                                      Text_title(data: 'Working time:'),
                                      Text_title(data: 'Last Update:'),

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
                                      Text_Value(data: '$ave_cell V'),
                                      Text_Value(data: '$bat_temp °C'),
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
                                      Text_Value(data: '$uptime'),
                                      Text_Value(data: '$last_update'),
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
        ) //Center
    );


  }
}


class  MymobileBodySTS extends StatefulWidget {
  const MymobileBodySTS();
  @override
  _MymobileBodySTSState createState() => _MymobileBodySTSState();
}

class _MymobileBodySTSState extends State<MymobileBodySTS> {
  final Storage _localStorage = window.localStorage;

  var bat_vol;
  var bat_cap;
  var bat_capacity;
  var bat_temp;
  var bat_percent;
  var bat_cycles;
  var box_temp;
  var uptime;
  var bat_current;
  var mos_temp;
  var ave_cell;
  var cell_diff;
  var last_update;

  Future<String?> _bat_vol() async => bat_vol = _localStorage['bat_vol'];
  Future<String?> _bat_cap() async => bat_cap = _localStorage['bat_cap'];

  Future<String?> _bat_capacity() async => bat_capacity = _localStorage['bat_capacity'];
  Future<String?> _bat_temp() async => bat_temp = _localStorage['bat_temp'];
  Future<String?> _bat_percent() async => bat_percent = _localStorage['bat_percent'];
  Future<String?> _bat_cycles() async => bat_cycles = _localStorage['bat_cycles'];
  Future<String?> _box_temp() async => box_temp = _localStorage['box_temp'];
  Future<String?> _uptime() async => uptime = _localStorage['uptime'];
  Future<String?> _tube_temp() async => mos_temp = _localStorage['tube_temp'];
  Future<String?> _bat_current() async => bat_current = _localStorage['bat_current'];
  Future<String?> _cell_diff() async => cell_diff = _localStorage['cell_diff'];
  Future<String?> _ave_cell() async => ave_cell = _localStorage['ave_cell'];
  Future<String?> _last_update() async => last_update = _localStorage['logger_status'];

  // Basic setting text
  TextEditingController  cellcount = TextEditingController();
  var _cellcount;
  TextEditingController batterycapacity = TextEditingController();
  var _batterycapacity;

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

  Future<String?> _Cellcount() async => _cellcount = _localStorage['strings_settings'];
  Future<String?> _Batterycapacity() async => _batterycapacity = _localStorage['battery_capacity_settings'];
  Future<String?> _CalibratingVolt() async => _calibratingVolt = _localStorage['bat_vol'];
  Future<String?> _CalibratingCurr() async => _calibratingCurr = _localStorage['bat_current'];
  Future<String?> _CellOVP() async => _cellOVP = _localStorage['single_overvoltage'];
  Future<String?> _CellOVPR() async => _cellOVPR = _localStorage['monomer_overvoltage_recovery'];
  Future<String?> _CellUVPR() async => _cellUVPR = _localStorage['discharge_overcurrent_protection_value'];
  Future<String?> _CellUVP() async => _cellUVP = _localStorage['differential_voltage_protection_value'];
  Future<String?> _ContinuedChargeCurr() async => _continuedChargeCurr = _localStorage['equalizing_opening_differential'];
  Future<String?> _ContinuedDischargeCurr() async => _continuedDischargeCurr = _localStorage['charging_overcurrent_delay'];
  Future<String?> _DischargeOCPdelay() async => _dischargeOCPdelay = _localStorage['equalizing_starting_voltage'];
  Future<String?> _ChargeOTP() async => _chargeOTP = _localStorage['high_temp_protect_bat_charge'];
  Future<String?> _DischargeOTP() async => _dischargeOTP = _localStorage['high_temp_protect_bat_discharge'];
  Future<String?> _ChargeUTP() async => _chargeUTP = _localStorage['charge_cryo_protect'];
  Future<String?> _ChargeUTPR() async => _chargeUTPR = _localStorage['recover_val_charge_cryoprotect'];
  Future<String?> _StartBalanceVolt() async => _startBalanceVolt = _localStorage['tube_temp_protection'];

  var id;
  Future<String?> _id() async => id = _localStorage['Id_device'];
  var token;
  Future<String?> _token() async => token = _localStorage['Token'];
  void _Read(){
    _id();_token();
    // Read status
    _bat_vol();_bat_cap();_bat_capacity();
    _bat_temp();_bat_percent();_bat_cycles();
    _box_temp();_uptime();_tube_temp();
    _bat_current();_cell_diff();_ave_cell();_last_update();
    // Read setting
    _Cellcount();_Batterycapacity();_CalibratingVolt();
    _CalibratingCurr();_CellOVP();_CellOVPR();_CellUVPR();
    _CellUVP();_ContinuedChargeCurr();_ContinuedDischargeCurr();
    _DischargeOCPdelay();_ChargeOTP();_DischargeOTP();
    _ChargeUTP();_ChargeUTPR();
    _StartBalanceVolt();

  }

  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    final _height_1 = 40*heightR;
    final _widht_1 = 100*heightR;
    // postDataSetting(id,"single_overvoltage",4200);
    // postDataSetting(id,"single_overvoltage",4200);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: CustomAppbar(),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white60,
          child: DrawerPage(),
        ),
        backgroundColor: Colors.black45,
        body: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 2)).asyncMap((event) => _Read()),
          builder: (context,snapshot) => SingleChildScrollView(
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
                                      Text_title(data: 'Ave. Cell Volt:'),
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
                                      Text_title(data: 'Working time:'),
                                      Text_title(data: 'Last Update:'),
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
                                      Text_Value(data: '$ave_cell V'),
                                      Text_Value(data: '$bat_temp °C'),
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
                                      Text_Value(data: '$uptime'),
                                      Text_Value(data: '$last_update'),
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.leftSlide,
                                          // headerAnimationLoop: false,
                                          // dialogType: DialogType.error,
                                          // showCloseIcon: true,
                                          title: 'Notification',
                                          desc:
                                          'Thông tin này không được thay đổi!',
                                          btnOkOnPress: () {
                                          },
                                          // btnOkIcon: Icons.cancel,
                                          onDismissCallback: (type) {
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
                                          animType: AnimType.leftSlide,
                                          // headerAnimationLoop: false,
                                          // dialogType: DialogType.error,
                                          // showCloseIcon: true,
                                          title: 'Notification',
                                          desc:
                                          'Thông tin này không được thay đổi!',
                                          btnOkOnPress: () {
                                          },
                                          // btnOkIcon: Icons.cancel,
                                          onDismissCallback: (type) {
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
                        width: 300 * heightR,
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
                                  child: Text_title(data:"Cont Charge Curr.(A):"),
                                ),
                                SizedBox(height: 20*heightR,),
                                Container(
                                  height: _height_1,
                                  child: Text_title(data:"Cont Discharge Curr.(A):"),
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
                                  width: _widht_1,
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
          ),
        ) //Center
    );
  }



  postDataSetting(final id,final propertyCode, final value) async{
    // print(propertyCode);
    // print(value);
    try{
      var response_setting = await http.post(
          Uri.parse(
              "http://smarthome.test.makipos.net:3028/users-control-devices"),
          headers: {
            "Content-type": "application/json",
            "Authorization": token,
          },
          body: jsonEncode(
              {
                "deviceId": id,
                "propertyCode": propertyCode,
                "localId": "1",
                "data": "$value",
                "waitResponse": false,
                "timeout": 1000
              }
          )
      );
      // print("BodySetting $propertyCode : ${response_setting.statusCode}");
    } catch(e){
      print(e);
    }
  }
}
