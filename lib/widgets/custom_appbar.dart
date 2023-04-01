import 'dart:convert';
import 'dart:html';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:makipos/view/login.dart';

import '../theme/colors.dart';
import '../view/ControlPage.dart';
import '../view/SettingsPage.dart';
import '../view/StatusPage.dart';
import '../view/home.dart';

class CustomAppbar extends StatefulWidget with PreferredSizeWidget {
  // CustomAppbar({Key? key,}) : super(key: key);
  const CustomAppbar();

  @override
  _CustomAppbarState createState() => _CustomAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 43);
}

class _CustomAppbarState extends State<CustomAppbar> {
  final Storage _localStorage = window.localStorage;
  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }
  var namedevice;

  Future<String?> _name() async => namedevice = _localStorage['Name_device'];
  _Delete(){
    save("Không có thiết bị", "Name_device");
    save("0", "Token");
    save("0", "List_Cell");
    // saveList(userMap["propertiesValue"]["cells_vol"], "cells_vol");
    // bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
    save("0", "bat_vol");
    // bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
    save("0", "bat_cap");
    // bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
    save("0",
        "bat_capacity");
    // bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
    save("0", "bat_temp");
    // bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
    save("0", "bat_percent");
    // bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
    save("0", "bat_cycles");
    // box_temp = userMap["propertiesValue"]["box_temp"].toString();
    save("0", "box_temp");
    // system_working_time = userMap["propertiesValue"]["logger_status"].toString();
    save("0",
        "logger_status");
    save("0", "tube_temp");

    save("0",
        "charging_mos_switch");
    save("0",
        "discharge_mos_switch");
    save("0",
        "active_equalization_switch");
    // charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
    // discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
    // balance = userMap["propertiesValue"]["active_equalization_switch"].toString();
    // mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
    // bat_current = (int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString();
    save("0", "bat_current");
    // var min = cells_vol[0];
    // var max = cells_vol[0];
    // var sum = cells_vol.reduce((value, current) => value + current);
    // for (var i = 0; i < cells_vol.length; i++) {
    //   // Calculate sum
    //   // sum += cells_vol[i];
    //   // Checking for largest value in the list
    //   if (cells_vol[i] > max) {
    //     max = cells_vol[i];
    //   }
    //   // Checking for smallest value in the list
    //   if (cells_vol[i] < min) {
    //     min = cells_vol[i];
    //   }
    // }
    // cell_diff = ((max - min)*0.001).toStringAsFixed(4);
    save("0", "cell_diff");
    // ave_cell = (sum / (cells_vol.length)).toStringAsFixed(2);
    save("0", "ave_cell");

    // Setting data

    // _cellOVP = userMap["propertiesValue"]["single_overvoltage"].toString();
    save("0",
        "single_overvoltage");
    // _cellOVPR = userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString();
    save(
        "0",
        "monomer_overvoltage_recovery");
    // _cellUVPR = userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString();
    save(
        "0",
        "discharge_overcurrent_protection_value");
    // _cellUVP = userMap["propertiesValue"]["differential_voltage_protection_value"].toString();
    save(
        "0",
        "differential_voltage_protection_value");
    // _continuedChargeCurr = userMap["propertiesValue"]["equalizing_opening_differential"].toString();
    save(
        "0",
        "equalizing_opening_differential");
    // _continuedDischargeCurr = userMap["propertiesValue"]["charging_overcurrent_delay"].toString();
    save("0",
        "charging_overcurrent_delay");
    // _dischargeOCPdelay = userMap["propertiesValue"]["equalizing_starting_voltage"].toString();
    save("0",
        "equalizing_starting_voltage");
    // _chargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString();
    save(
        "0",
        "high_temp_protect_bat_charge");
    // _dischargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString();
    save(
        "0",
        "high_temp_protect_bat_discharge");
    // _chargeUTP = userMap["propertiesValue"]["charge_cryo_protect"].toString();
    save("0",
        "charge_cryo_protect");
    // _chargeUTPR =  userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString();
    save(
        "0",
        "recover_val_charge_cryoprotect");
    // _startBalanceVolt = userMap["propertiesValue"]["tube_temp_protection"].toString();
    save("0",
        "tube_temp_protection");
    // _cellcount = userMap["propertiesValue"]["strings_settings"].toString();
    save("0",
        "strings_settings");
    // _batterycapacity = userMap["propertiesValue"]["battery_capacity_settings"].toString();
    save("0",
        "battery_capacity_settings");
  }
  @override
  Widget build(BuildContext context) {
    double heightR, widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;
    return Container(
        padding: EdgeInsets.only(left: 50 * widthR, right: 15 * widthR, top: 10 * heightR),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // IconButton(
            //   onPressed: () => showDialog(
            //       context: context,
            //       builder: (BuildContext context) => AlertDialog(
            //             backgroundColor: Colors.grey[200],
            //             title: Center(
            //               child: Text(
            //                 'List Device',
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 32 * heightR,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //             ),
            //             actions: <Widget>[
            //               SizedBox(
            //                 height: 600 * heightR,
            //                 width: 800 * heightR,
            //                 child: ListView.builder(
            //                     itemCount: ListID.length,
            //                     itemBuilder:
            //                         (BuildContext context, int index) {
            //                       return Column(
            //                         children: [
            //                           Container(
            //                               color: Colors.black54,
            //                               height: 50 * heightR,
            //                               width: 300 * heightR,
            //                               child: Column(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment
            //                                         .spaceBetween,
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.center,
            //                                 children: [
            //                                   TextButton(
            //                                       onPressed: () {
            //                                         AwesomeDialog(
            //                                           context: context,
            //                                           animType: AnimType
            //                                               .leftSlide,
            //                                           headerAnimationLoop:
            //                                               false,
            //                                           dialogType:
            //                                               DialogType
            //                                                   .success,
            //                                           showCloseIcon: true,
            //                                           title:
            //                                               'Notification',
            //                                           desc:
            //                                               'Xác nhận đổi thiết bị ???',
            //                                           btnOkOnPress: () {
            //                                             save(
            //                                                 _data[index][
            //                                                         "_id"]
            //                                                     .toString(),
            //                                                 "Id_device");
            //                                             get_device(
            //                                                 index,
            //                                                 _data[index][
            //                                                         "_id"]
            //                                                     .toString());
            //                                             Navigator.push(
            //                                                 context,
            //                                                 MaterialPageRoute(
            //                                                   builder:
            //                                                       (context) =>
            //                                                           Home(),
            //                                                 ));
            //                                           },
            //                                         ).show();
            //                                       },
            //                                       child: Container(
            //                                         child: Text(
            //                                           "${_data[index]["productId"]}",
            //                                           style: TextStyle(
            //                                             fontSize:
            //                                                 24 * heightR,
            //                                             color:
            //                                                 Colors.white,
            //                                           ),
            //                                         ),
            //                                       )),
            //                                 ],
            //                               )),
            //                           SizedBox(
            //                             height: 10 * heightR,
            //                           ),
            //                         ],
            //                       );
            //                     }),
            //               )
            //             ],
            //           )),
            //   icon: Icon(
            //     Icons.menu,
            //     color: secondary,
            //     size: 30 * heightR,
            //   ),
            // ),
            SizedBox(),
            SizedBox(),
            StreamBuilder(
                stream: Stream.periodic(Duration(seconds: 1))
                    .asyncMap((event) => _name()),
                builder: (context, snapshot) => Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${namedevice}",
                            style: TextStyle(
                                color: Colors.cyanAccent,
                                fontSize: 26 * heightR),
                          ),
                          Text(
                            "${DateFormat("yyyy-MM-dd").format(DateTime.now())} ${DateFormat.Hms().format(DateTime.now())}",
                            style: TextStyle(
                                color: Colors.white, fontSize: 24 * heightR),
                          ),
                        ],
                      ),
                    )),
            SizedBox(),
            PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: secondary,
                  size: 30 * heightR,
                ),
                // color: secondary,
                // elevation: 20,
                // enabled: true,
                onSelected: (value) {
                  if (value == 'logout') {
                    _Delete();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInPage(),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Logout"),
                        value: "logout",
                      ),
                      // PopupMenuItem(
                      //   child: Text("Second"),
                      //   value: "Second",
                      // ),
                    ]),
          ],
        ));
  }
}

class DrawerPage extends StatefulWidget {
  const DrawerPage({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final Storage _localStorage = window.localStorage;
  var token;

  Future<String?> _token() async => token = _localStorage['Token'];
  var namedevice;

  Future<String?> _name() async => namedevice = _localStorage['Name_device'];
  var _data;
  var length;
  var ListID = [];
  var ListStatus = [];
  int i = 0;

  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }

  getData() async {
    _token();
    _name();
    try {
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      _data = userMap["data"];
      if (i == 0) {
        while (true) {
          ListID.add(_data[i]["productId"].toString());
          ListStatus.add(_data[i]["status"].toString());
          i++;
        }
      }
    } catch (e) {}
  }

  get_device(int x, String iddevice) async {
    try {
      var Get_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(Get_Listdevice.body);
      // name_device = userMap["data"][x]["productId"].toString();
      save(userMap["data"][x]["productId"].toString(), "Name_device");
      get(iddevice);
    } catch (e) {
      print(e);
    }
  }

  get(String id_device) async {
    try {
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id_device"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);

      var cells_vol = userMap["propertiesValue"]["cells_vol"];
      save(cells_vol.toString(), "List_Cell");
      // saveList(userMap["propertiesValue"]["cells_vol"], "cells_vol");
      // bat_vol = userMap["propertiesValue"]["bat_vol"].toString();
      save(userMap["propertiesValue"]["bat_vol"].toString(), "bat_vol");
      // bat_cap = userMap["propertiesValue"]["bat_cap"].toString();
      save(userMap["propertiesValue"]["bat_cap"].toString(), "bat_cap");
      // bat_capacity = userMap["propertiesValue"]["bat_capacity"].toString();
      save(userMap["propertiesValue"]["bat_capacity"].toString(),
          "bat_capacity");
      // bat_temp = userMap["propertiesValue"]["bat_temp"].toString();
      save(userMap["propertiesValue"]["bat_temp"].toString(), "bat_temp");
      // bat_percent = userMap["propertiesValue"]["bat_percent"].toString();
      save(userMap["propertiesValue"]["bat_percent"].toString(), "bat_percent");
      // bat_cycles = userMap["propertiesValue"]["bat_cycles"].toString();
      save(userMap["propertiesValue"]["bat_cycles"].toString(), "bat_cycles");
      // box_temp = userMap["propertiesValue"]["box_temp"].toString();
      save(userMap["propertiesValue"]["box_temp"].toString(), "box_temp");
      // system_working_time = userMap["propertiesValue"]["logger_status"].toString();
      save(userMap["propertiesValue"]["logger_status"].toString(),
          "logger_status");
      save(userMap["propertiesValue"]["tube_temp"].toString(), "tube_temp");

      save(userMap["propertiesValue"]["charging_mos_switch"].toString(),
          "charging_mos_switch");
      save(userMap["propertiesValue"]["discharge_mos_switch"].toString(),
          "discharge_mos_switch");
      save(userMap["propertiesValue"]["active_equalization_switch"].toString(),
          "active_equalization_switch");
      // charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
      // discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
      // balance = userMap["propertiesValue"]["active_equalization_switch"].toString();
      // mos_temp = userMap["propertiesValue"]["tube_temp"].toString();
      // bat_current = (int.parse(userMap["propertiesValue"]["bat_current"].toString()) * 0.01).toString();
      save(
          (int.parse(userMap["propertiesValue"]["bat_current"].toString()) *
                  0.01)
              .toString(),
          "bat_current");
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
      save(((max - min) * 0.001).toStringAsFixed(4), "cell_diff");
      // ave_cell = (sum / (cells_vol.length)).toStringAsFixed(2);
      save((sum / (cells_vol.length)).toStringAsFixed(2), "ave_cell");

      // Setting data

      // _cellOVP = userMap["propertiesValue"]["single_overvoltage"].toString();
      save(userMap["propertiesValue"]["single_overvoltage"].toString(),
          "single_overvoltage");
      // _cellOVPR = userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString();
      save(
          userMap["propertiesValue"]["monomer_overvoltage_recovery"].toString(),
          "monomer_overvoltage_recovery");
      // _cellUVPR = userMap["propertiesValue"]["discharge_overcurrent_protection_value"].toString();
      save(
          userMap["propertiesValue"]["discharge_overcurrent_protection_value"]
              .toString(),
          "discharge_overcurrent_protection_value");
      // _cellUVP = userMap["propertiesValue"]["differential_voltage_protection_value"].toString();
      save(
          userMap["propertiesValue"]["differential_voltage_protection_value"]
              .toString(),
          "differential_voltage_protection_value");
      // _continuedChargeCurr = userMap["propertiesValue"]["equalizing_opening_differential"].toString();
      save(
          userMap["propertiesValue"]["equalizing_opening_differential"]
              .toString(),
          "equalizing_opening_differential");
      // _continuedDischargeCurr = userMap["propertiesValue"]["charging_overcurrent_delay"].toString();
      save(userMap["propertiesValue"]["charging_overcurrent_delay"].toString(),
          "charging_overcurrent_delay");
      // _dischargeOCPdelay = userMap["propertiesValue"]["equalizing_starting_voltage"].toString();
      save(userMap["propertiesValue"]["equalizing_starting_voltage"].toString(),
          "equalizing_starting_voltage");
      // _chargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString();
      save(
          userMap["propertiesValue"]["high_temp_protect_bat_charge"].toString(),
          "high_temp_protect_bat_charge");
      // _dischargeOTP = userMap["propertiesValue"]["high_temp_protect_bat_discharge"].toString();
      save(
          userMap["propertiesValue"]["high_temp_protect_bat_discharge"]
              .toString(),
          "high_temp_protect_bat_discharge");
      // _chargeUTP = userMap["propertiesValue"]["charge_cryo_protect"].toString();
      save(userMap["propertiesValue"]["charge_cryo_protect"].toString(),
          "charge_cryo_protect");
      // _chargeUTPR =  userMap["propertiesValue"]["recover_val_charge_cryoprotect"].toString();
      save(
          userMap["propertiesValue"]["recover_val_charge_cryoprotect"]
              .toString(),
          "recover_val_charge_cryoprotect");
      // _startBalanceVolt = userMap["propertiesValue"]["tube_temp_protection"].toString();
      save(userMap["propertiesValue"]["tube_temp_protection"].toString(),
          "tube_temp_protection");
      // _cellcount = userMap["propertiesValue"]["strings_settings"].toString();
      save(userMap["propertiesValue"]["strings_settings"].toString(),
          "strings_settings");
      // _batterycapacity = userMap["propertiesValue"]["battery_capacity_settings"].toString();
      save(userMap["propertiesValue"]["battery_capacity_settings"].toString(),
          "battery_capacity_settings");
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


    return StreamBuilder(
      stream:
          Stream.periodic(Duration(milliseconds: 100)).asyncMap((event) => getData()).take(1),
      builder: (context, snapshot) => Center(
        child: ListView.builder(
            itemCount: ListID.length + 1,
            itemBuilder: (BuildContext context, int index) {
              index = index -1;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  index == -1   ? Container(
                      height: 200 * heightR,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Center(
                        child: Text(
                          'ListDevice',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      )
                  ) :Container(
                      color: Colors.black54,
                      height: 70 * heightR,
                      // width: 800 * heightR,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           TextButton(
                              onPressed: () {
                                AwesomeDialog(
                                  context: context,
                                  animType: AnimType.leftSlide,
                                  headerAnimationLoop: false,
                                  dialogType: DialogType.success,
                                  showCloseIcon: true,
                                  title: 'Notification',
                                  desc: 'Xác nhận đổi thiết bị ???',
                                  btnOkOnPress: () {
                                    save(_data[index]["_id"].toString(),
                                        "Id_device");
                                    get_device(index,
                                        _data[index]["_id"].toString());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ));
                                  },
                                ).show();
                              },
                              child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Icon(
                                        Icons.devices,
                                        size: 40*heightR,
                                        color: ListStatus[index] == "OFFLINE" ? Colors.red : Colors.green[500],
                                      ),
                                      SizedBox(),
                                      Text(
                                        "${ListID[index]}",
                                        style: TextStyle(
                                          fontSize: 24 * heightR,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(),
                                    ],
                                  )
                              )),
                        ],
                      )),
                  SizedBox(
                    height: 10 * heightR,
                  ),
                ],
              );
            }),
      )

    );
  }
}
