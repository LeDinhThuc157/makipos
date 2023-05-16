
import 'dart:convert';
import 'dart:html';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_forest/flat_icons_medium.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../widgets/custom_appbar.dart';

class  AlarmPage extends StatefulWidget {
  AlarmPage({Key ? key, required this.list_warning,required this.list_time,}):super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
  var list_warning;
  var list_time;
}

class _AlarmPageState extends State<AlarmPage>{
  // final Storage _localStorage = window.localStorage;
  // var list_warning = [];
  // var list_time = [];
  // var token;
  // var id_device;
  //
  // Future<String?> _Token() async => token = _localStorage['Token']!;
  // Future<String?> _Id() async => id_device = _localStorage['Id_device']!;
  //
  //
  // var getdata;
  // var time,limit,skip;
  // readJson() async {
  //   final data = await json.decode(response);
  //   time = data["time"];
  //   limit = data["limit"];
  //   skip = data["skip"];
  // }
  // get_list_warning(var token, var id_device) async {
  //   try {
  //     final dio = Dio();
  //     Map<String, String> qParams = {
  //       'deviceId': '$id_device',
  //       '$time': '-1',
  //       '$limit': '200',
  //       'eventType': 'UPDATE_PROPERTY',
  //       '$skip': '0',
  //     };
  //     var responseGet_Listdevice = await dio.get(
  //         "http://smarthome.test.makipos.net:3028/devices-events",
  //         options: Options(
  //           headers: {"Authorization": token},
  //         ),
  //         queryParameters: qParams
  //     );
  //     Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.toString());
  //     getdata = userMap;
  //     int i = 0;
  //     while( i != 200){
  //       var warning = getdata['data'][i]["eventDescription"]["propertyCode"];
  //       if(warning == "warning" || warning == "Warning"){
  //         var data_pc = getdata['data'][i]["eventDescription"]["data"];
  //         list_warning.add(data_pc);
  //         var time = getdata['data'][i]['time'];
  //         var day_sub = time.substring(0, 10);
  //         var clock_sub = time.substring(11,19);
  //         list_time.add( clock_sub+ "  " + day_sub);
  //       }
  //       i++;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //
  // }
  // Loading(){
  //   try{
  //     _Token();_Id();
  //     readJson();
  //     get_list_warning(token, id_device);
  //   }catch(e){
  //     print(e);
  //   }
  // }
  // Loading(){
  //   try{
  //     _List_Time();
  //     _List_Warning();
  //
  //     var fix_warning= list_warning_down.toString();
  //     fix_warning = fix_warning.substring(2,fix_warning.length-2);
  //      list_warning = fix_warning.split(",");
  //      print("le: ${list_warning.length}");
  //     var fix_time= list_time.toString();
  //     fix_time = fix_time.substring(2,fix_time.length-2);
  //     list_time = fix_time.split(",");
  //     print("le: ${list_time}");
  //     print("le: ${list_time.length}");
  //   }catch(e){
  //     print(e);
  //   }
  //
  // }
  @override
  Widget build(BuildContext context) {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomAppbar(),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white60,
        child: DrawerPage(),
      ),
      body: ListView.builder(
        itemCount: widget.list_warning.length,
        itemBuilder: (context, index) {
          return  Column(
            children: [
              SizedBox(
                height: 10*heightR,
              ),
              Container(
                height: 70*heightR,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Icon(
                      Icons.warning,
                      color: Colors.yellow,
                      size: 40*heightR,
                    ),
                    Text(widget.list_time[index],
                      style: TextStyle(
                        fontSize: 24 * heightR,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(
                      width: 350*heightR,
                      child: Container(
                        child: Text(widget.list_warning[index],
                          style: TextStyle(
                            fontSize: 28 * heightR,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                    SizedBox(),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

}