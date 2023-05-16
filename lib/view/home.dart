import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makipos/view/Alarm_tab.dart';

import '../responsive/mobile_body.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/bottombar_item.dart';
import '../theme/colors.dart';
import 'ControlPage.dart';
import 'SettingsPage.dart';
import 'StatusPage.dart';


class Home extends StatefulWidget {
  const Home({Key ? key,});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    // print("Home Token: $_token");
    // print("Token user login: ${widget._token.toString()}");
    return Container(
      decoration: BoxDecoration(
        color: appBgColor.withOpacity(.95),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40)
        ),
      ),

      child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: getBottomBar(),
          // Nếu có floatingActionButton thì không các button sẽ bị vo hiệu hóa không hoạt động.
          // floatingActionButton: getHomeButton(),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          body: getBarPage()
      ),
    );
  }
  Widget getHomeButton(){
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Container(
      margin: EdgeInsets.only(top: 28*heightR),
      // padding: EdgeInsets.all(30*heightR),
      child: GestureDetector(
        onTap: () {
          // activeTab = 0;
          setState(() {
           activeTab = 0;
          });
        },
      ),
    );
  }

  Widget getBottomBar() {

    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;

    return StreamBuilder(
        stream: Stream.periodic(Duration(milliseconds: 100)).asyncMap((event) => _Id()).take(1),
        builder: (context, snapshot) => Container(
          height: 100*heightR,
          width: double.infinity,
          decoration: BoxDecoration(
              color: mainColor,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(25),
              //   topRight: Radius.circular(25)
              // ),
              boxShadow: [
                BoxShadow(
                    color: mainColor.withOpacity(0.1),
                    blurRadius: .5,
                    spreadRadius: .5,
                    offset: Offset(0, 1)
                )
              ]
          ),
          child: Padding(
              padding:  EdgeInsets.only(top:15*heightR,left: 125*widthR, right: 125*widthR),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BottomBarItem(
                      Icons.desktop_mac_outlined,
                      "STATUS",
                      isActive: activeTab == 0,
                      activeColor: secondary,
                      onTap: () {
                        setState(() {
                          activeTab = 0;
                        });
                      },
                    ),
                    BottomBarItem(
                      Icons.settings,
                      "SETTINGS",
                      isActive: activeTab == 1,
                      activeColor: secondary,
                      onTap: () {
                        setState(() {
                          activeTab = 1;
                        });
                      },
                    ),
                    BottomBarItem(
                      Icons.swap_horiz,
                      "CONTROL",
                      isActive: activeTab == 2,
                      activeColor: secondary,
                      onTap: () {
                        setState(() {
                          activeTab = 2;
                        });
                      },
                    ),
                    BottomBarItem(
                      Icons.notification_important_outlined,
                      "ALARM",
                      isActive: activeTab == 3,
                      activeColor: red_alarm,
                      onTap: () {
                        setState(() {
                          activeTab = 3;
                        });
                      },
                    ),


                  ]
              )
          ),

    ),);
  }

  final Storage _localStorage = window.localStorage;
  var token;
  var id_device;

  Future<String?> _Token() async => token = _localStorage['Token']!;
  Future<String?> _Id() async => id_device = _localStorage['Id_device']!;
  var getdata;
  var time,limit,skip;

  @override
  void initState(){
    super.initState();
    _Token();_Id();
  }
  var list_warning=[];
  var list_time = [];
  var list_warning_1=[];
  var list_time_1 = [] ;
  get_list_warning(var token, var id_device) async {
    try {
      list_warning_1 = [];
      list_time_1 = [];
      list_warning = [];
      list_time = [];
      final dio = Dio();
      Map<String, String> qParams = {
        'deviceId': '$id_device',
        '\$sort[time]': '-1',
        '\$limit': '200',
        'eventType': 'UPDATE_PROPERTY',
        '\$skip': '0',
      };
      var responseGet_Listdevice = await dio.get(
          "http://smarthome.test.makipos.net:3028/devices-events",
          options: Options(
            headers: {"Authorization": token},
          ),
          queryParameters: qParams
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.toString());
      getdata = userMap;
      int i = 0;
      while( i != 200){
        var warning = getdata['data'][i]["eventDescription"]["propertyCode"];
        if(warning == "warning" || warning == "Warning"){
          if(getdata['data'][i]["eventDescription"]["data"] != "NORMAL"){
            var data_pc = getdata['data'][i]["eventDescription"]["data"];
            list_warning_1.add(data_pc);
            var time = getdata['data'][i]['time'];
            var day_sub = time.substring(0, 10);
            var clock_sub = time.substring(11,19);
            list_time_1.add( clock_sub+ "  " + day_sub);
          }
        }
        i++;
      }
      for(int j = 0; j < list_warning_1.length; j++){
        if(j == 0){
          list_warning.add(list_warning_1[j]);
          list_time.add(list_time_1[j]);
          continue;
        }
        if(list_warning_1[j] != list_warning_1[j-1] && j != 0){
          list_warning.add(list_warning_1[j]);
          list_time.add(list_time_1[j]);
        }
      }
    } catch (e) {
      print(e);
    }

  }
  // _Loading(){
  //   try{
  //     get_list_warning(token, id_device);
  //     print("Complete");
  //     print("Warning: 123 ${list_warning} \n");
  //   }catch(e){
  //     print(e);
  //   }
  // }
  Widget getBarPage(){
    return IndexedStack(
        index: activeTab,
        children: <Widget>[
          ResponsiveLayout(
              mobileBody: MymobileBodySTT(),
              desktopBody: StatusPage()
              ),
          ResponsiveLayout(
              mobileBody: MymobileBodySTS(),
              desktopBody: SettingsPage()
          ),
          ControlPage(),
          activeTab != 3 ? AlarmPage(list_warning: list_warning, list_time: list_time,) :
          StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 1)).asyncMap((event) => get_list_warning(token,id_device)).take(1),
              builder: (context, snapshot) => AlarmPage(list_warning: list_warning, list_time: list_time,)
          ),

        ],
      );
  }
}
