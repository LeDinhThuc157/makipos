import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
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

class  StatusPage extends StatefulWidget {
  const StatusPage(
       this._token,
  );
  final String _token;
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

  Boolvalue(){
    if(charge == "1"){
      charbool = true;
    }
    if(charge == "0"){
      charbool = false;
    }
    if(discharge == "1"){
      dischabool = true;
    }
    if(discharge == "0"){
      dischabool = false;
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
  String id = "63be79a13ea8bc0007797118";
  postData() async {
    try {
      //4.Thông tin thiết bị.

      var responseGet_Listdevice = await http.get(
        Uri.parse("https://smarthome.test.makipos.net:3029/devices/$id"),
        headers: {
          "Authorization": widget._token.toString()
        },
      );
      print("StatusListDevice: ${responseGet_Listdevice.statusCode}");
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      print("Time: ${userMap["propertiesValue"]["uptime"]}");

      setState(() {
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
        system_working_time = userMap["propertiesValue"]["system_working_time"].toString();
        bat_current = userMap["propertiesValue"]["bat_current"].toString();
        charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
        discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
        mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
      });
    } catch (e) {
      print(e);
    }

    //1.Thông tin tạo tài khoản login.
//       var response_user_login = await http.post(
//           Uri.parse(
//               "https://smarthome.test.makipos.net:3029/users-service/users/authentication?_v=1"),
//           headers: {
//             "Content-type": "application/json; charset=utf-8",
//             // "Accept": "application/json",
//             // "Ocp-Apim-Subscription-Key": "63b5363c0a3a520007fa2ab9",
//             // "Ocp-Apim-Trace": "true"
//           },
//           body: jsonEncode({
//             "authCode": false,
//             "strategy": "local",
//             "username": "BMS_admin",
//             "password": "01012023"
//           })
//       );
//       print("Status_response_user_login:${response_user_login.statusCode}");
//       print("LoginUsers:${response_user_login.body}");

//2.Tạo tài khoản.

    // var response_create_user = await http.post(
    //     Uri.parse("https://smarthome.test.makipos.net:3029/users"),
    //     headers: {
    //       "Content-type": "application/json; charset=utf-8",
    //       // "Accept": "application/json",
    //       // "Ocp-Apim-Subscription-Key": "63b5363c0a3a520007fa2ab9",
    //       // "Ocp-Apim-Trace": "true"
    //     },
    //     body: jsonEncode(
    //         {
    //       "username": "bms_user_test_11",
    //       "password": "123456789",
    //       "manufacturerId": "63b5363c0a3a520007fa2ab9",
    //       "roles": [
    //         "user"
    //       ],
    //     }
    //     ));
    // print("Body_response_create:${response_create_user.body}");
    // print("Status_response_create:${response_create_user.statusCode}");
    // print("CreateUsers:${create["message"]["message"]}");

//3.Thông tin all tài khoản.

    // var responseGet_User = await http.get(
    //   Uri.parse("https://smarthome.test.makipos.net:3029/users"),
    //   headers: {
    //     // "Accept": "application/json",
    //     "Authorization":
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2M2I1M2M0NDYxMjVkYjAwMDdjYTIwZmMiLCJ1c2VybmFtZSI6IkJNU19hZG1pbiIsInR5cGUiOiJ1c2VyIiwiaWF0IjoxNjcyODI4NTA3LCJleHAiOjEwMzEyODI4NTA3LCJhdWQiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJpc3MiOiJodHRwOi8vc2VydmVyLm1ha2lwb3MubmV0OjMwMjgiLCJzdWIiOiIiLCJqdGkiOiI0MjA5OTUxNS0zZmY2LTQ0OTgtYmMxYS02NDg1MmEzM2U5ZjcifQ.HfJz87PI0G1T9nUF0doesD6sY-KTKSbZuJgaWfWN0Uo",
    //   },
    // );
    // print("StatusUsers: ${responseGet_User.statusCode}");
    // print("BodyUsers: ${responseGet_User.body}");
  }
  @override
  Widget build(BuildContext context) {
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    postData();
    Boolvalue();
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5*heightR,),


            Container(
              height: 50*heightR,
              padding: EdgeInsets.only(left: 300*heightR,right: 300*heightR),
              color: mainColor,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: charbool ?
                  Text(
              'Charge: ON',
                style: TextStyle(
                  color: secondary,
                  fontSize: 24*heightR,
                ),
              ): Text(
                    'Charge: OFF',
                    style: TextStyle(
                      color: secondary,
                      fontSize: 24*heightR,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 300*heightR,right: 300*heightR),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          color: Colors.green,
                          width: 2.0,
                          style: BorderStyle.solid
                      ),
                      left: BorderSide(
                          color: Colors.green,
                          width: 2.0,
                          style: BorderStyle.solid
                      ),
                    ),
                  ),
                  child: dischabool ? Text(
                    'Discharge: ON',
                    style: TextStyle(
                      color: secondary,
                      fontSize: 24*heightR,
                    ),
                  ):Text(
                    'Discharge: OFF',
                    style: TextStyle(
                      color: secondary,
                      fontSize: 24*heightR,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Balance: ON',
                    style: TextStyle(
                      color: secondary,
                      fontSize: 24*heightR,
                    ),
                  ),
                ),
              ],
            ),
            ),
            SizedBox(
              height: 5*heightR,
            ),
            Container(
              padding: EdgeInsets.only(left: 400*heightR,right: 200*heightR),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black54
              ),
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "$bat_vol mV",
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20*heightR,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text_title(
                                data:'MOS Temp:'
                            ),
                            Text_title(
                                data:'Battery Capacity:'
                            ),
                            Text_title(
                                data:'Cycle Capacity:'
                            ),
                            Text_title(
                                data:'Ave. Cell Volt(Chưa có):'
                            ),
                            Text_title(
                                data:'Battery T2:'
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5*heightR,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text_Value(
                                data: '$mos_temp°C',
                            ),
                            Text_Value(
                                data:'$bat_cap AH'
                            ),
                            Text_Value(
                                data:'$bat_capacity AH'
                            ),
                            Text_Value(
                                data:'3.384V'
                            ),
                            Text_Value(
                                data:'$bat_temp °C'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 400*heightR,
                  ),

                  Container(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text_title(
                                data:'Remain Battery:'
                            ),
                            // Text_title(
                            //     data:'Remain Capacity(Khong co):'
                            // ),
                            Text_title(
                                data:'Cycle Count:'
                            ),
                            Text_title(
                                data:'Cell Volt.Diff:'
                            ),
                            Text_title(
                                data:'Battery T1:'
                            ),
                            // Text_title(
                            //     data:'Battery T3(Khoong co):'
                            // ),
                            // Text_title(
                            //     data:'Heating Status(Khong co):'
                            // ),
                            // Text_title(
                            //     data:'Charg.Plugged(Khong co):'
                            // ),
                            Text_title(
                                data:'Time Emerg:'
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5*heightR,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text_Value(
                              data: '$bat_percent%',
                            ),
                            // Text_Value(
                            //     data:'396.0AH'
                            // ),
                            Text_Value(
                                data:'$bat_cycles'
                            ),
                            Text_Value(
                                data:'0.002V'
                            ),
                            Text_Value(
                                data:'$box_temp°C'
                            ),
                            // Text_Value(
                            //     data:'23.5°C'
                            // ),
                            // Text_Value(
                            //     data:'OFF'
                            // ),
                            // Text_Value(
                            //     data:'Plugged'
                            // ),
                            Text_Value(
                                data:'$system_working_time'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20*heightR,
                  ),
                  Container(
                    child: Text(
                      '$bat_current A',
                      style: TextStyle(
                        color: Colors.greenAccent[400],
                        fontSize: 50,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(

              child: Column(
                children: [
                  Text(
                    "Cells Voltage",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                      fontSize: 36*heightR,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "01",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_1_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "02",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_2_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "03",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_3_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "04",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_4_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "05",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_5_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "06",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_6_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "07",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_7_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "08",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_8_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "09",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_9_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "10",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_10_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "11",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_11_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "12",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_12_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "13",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_13_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "10",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_10_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "11",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_11_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "12",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_12_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "13",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_13_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20*heightR,
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    "13",
                                    style:TextStyle(
                                      color: secondary,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 40*heightR,
                                  alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 10*heightR,
                                ),
                                Text("${cell_13_vol}V",
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(),
                    ],
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
      ), //Center
    );
  }




}



