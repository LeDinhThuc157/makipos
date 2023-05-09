
import 'dart:convert';
import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import '../theme/colors.dart';
import '../widgets/custom_appbar.dart';

class  ControlPage extends StatefulWidget {
  ControlPage({Key? key,}): super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();

}

class _ControlPageState extends State<ControlPage> {
  var user,password;
  var name_device;
  var token;
  //
  var id;
  var isOn_charge ;
  var isOn_discharge ;
  var charge;
  var discharge;
  // var checkct = false;
  var data_1;
  var isOn_charge_mqtt = false;
  var isOn_discharge_mqtt = false ;
  var check_1 = false,check_2 = false;
  final Storage _localStorage = window.localStorage;
  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }
  @override
  void initState(){
    super.initState();
    _Read();
    _MQTT("${name_device}");
  }
  Future<String?> _charge() async => charge = _localStorage['charging_mos_switch'];
  Future<String?> _discharge() async => discharge = _localStorage['discharge_mos_switch'];
  Future<String?> _user() async => user = _localStorage['username'];
  Future<String?> _pass() async => password = _localStorage['password'];
  Future<String?> _namedevice() async => name_device = _localStorage['Name_device'];
  Future<String?> _id() async => id = _localStorage['Id_device'];
  Future<String?> _token() async => token = _localStorage['Token'];
  void _Read(){
    Value();
    // _charge();_discharge();
    _id();
    _user();_pass();_namedevice();
    _token();
    // print("charge: $charge \n discharge: $discharge");
    _Check_value();

  }
  void Value(){
    try{
      _charge();_discharge();
      _SoSanh();
    }catch(e){
      print(e);
    }
  }
   _SoSanh() async {
    try{
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      if(userMap["propertiesValue"]["charging_mos_switch"].toString() != charge){
        save(userMap["propertiesValue"]["charging_mos_switch"].toString(), "charging_mos_switch");
        charge = userMap["propertiesValue"]["charging_mos_switch"].toString();
      }
      if(userMap["propertiesValue"]["discharge_mos_switch"].toString() != discharge){
        save(userMap["propertiesValue"]["discharge_mos_switch"].toString(), "discharge_mos_switch");
        discharge = userMap["propertiesValue"]["discharge_mos_switch"].toString();
      }
    }catch(e){
      print(e);
    }
  }
  void _Check_value(){
    if(charge == "1"){
      check_1 ? isOn_charge_mqtt = true : isOn_charge = true;
    }
    if(charge == "0"){
      check_1 ? isOn_charge_mqtt = false : isOn_charge = false;
    }
    if(discharge == "1"){
      check_2 ? isOn_discharge_mqtt = true : isOn_discharge = true;
    }
    if(discharge == "0"){
      check_2 ? isOn_discharge_mqtt = false : isOn_discharge = false;
    }
  }

  _MQTT(String device) async {

    final client = MqttBrowserClient('ws://smarthome.test.makipos.net:8083/mqtt', '${user}');
    /// Set logging on if needed, defaults to off
    client.logging(on: false);
    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();

    /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
    client.keepAlivePeriod = 20;

    /// The connection timeout period can be set if needed, the default is 5 seconds.
    client.connectTimeoutPeriod = 2000; // milliseconds

    /// The ws port for Mosquitto is 8080, for wss it is 8081
    client.port = 8083;
    /// Add the unsolicited disconnection callback
    // client.onDisconnected = onDisconnected;
    //
    // /// Add the successful connection callback
    // client.onConnected = onConnected;
    //
    //
    //
    // /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    // /// You can add these before connection or change them dynamically after connection if
    // /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    // /// can fail either because you have tried to subscribe to an invalid topic or the broker
    // /// rejects the subscribe request.
    // client.onSubscribed = onSubscribed;
    // // client.onSubscribeFail = onSubscribeFail;
    //
    // /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    // /// from the broker.
    // client.pongCallback = pong;

    /// Set the appropriate websocket headers for your connection/broker.
    /// Mosquito uses the single default header, other brokers may be fine with the
    /// default headers.
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;

    try {
      await client.connect(user,password);
      client.subscribe('d/$device/p/UP/#', MqttQos.atLeastOnce);
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
      return -1;
    }
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
      MqttPublishPayload.bytesToStringAsString(message.payload.message);
      data_1 = jsonDecode(payload);
      if(data_1[0]['pc'].toString() == 'charging_mos_switch' && data_1 != null){
        check_1 = true;
        if(data_1[0]['d'].toString() == '0'){
          isOn_charge_mqtt = false;
          // print("charging_mos_switch: ${isOn_charge_mqtt}");
        }
        if(data_1[0]['d'].toString() == '1'){
          isOn_charge_mqtt = true;
          // print("charging_mos_switch: ${isOn_charge_mqtt}");

        }
        save(data_1[0]['d'].toString(), "charging_mos_switch");
        setState(() {

        });
      }
      if(data_1[0]['pc'].toString() == 'discharge_mos_switch' && data_1!=null){
        check_2 = true;
        if(data_1[0]['d'].toString() == '0'){
          isOn_discharge_mqtt = false;
          // print("discharge_mos_switch: ${isOn_discharge_mqtt}");
        }
        if(data_1[0]['d'].toString() == '1'){
          isOn_discharge_mqtt = true;
          // print("discharge_mos_switch: ${isOn_discharge_mqtt}");
        }
        save(data_1[0]['d'].toString(), "discharge_mos_switch");
        setState(() {

        });
      }
    });
  }

  // _Publish(String device, String protoco, var _check) async {
  //   final client = MqttBrowserClient('ws://smarthome.test.makipos.net:8083/mqtt', '${widget.user}');
  //   /// Set logging on if needed, defaults to off
  //   client.logging(on: false);
  //   /// Set the correct MQTT protocol for mosquito
  //   client.setProtocolV311();
  //
  //   /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
  //   client.keepAlivePeriod = 20;
  //
  //   /// The connection timeout period can be set if needed, the default is 5 seconds.
  //   client.connectTimeoutPeriod = 2000; // milliseconds
  //
  //   /// The ws port for Mosquitto is 8080, for wss it is 8081
  //   client.port = 8083;
  //   /// Add the unsolicited disconnection callback
  //   client.onDisconnected = onDisconnected;
  //
  //   /// Add the successful connection callback
  //   client.onConnected = onConnected;
  //
  //
  //
  //   /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
  //   /// You can add these before connection or change them dynamically after connection if
  //   /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
  //   /// can fail either because you have tried to subscribe to an invalid topic or the broker
  //   /// rejects the subscribe request.
  //   client.onSubscribed = onSubscribed;
  //   // client.onSubscribeFail = onSubscribeFail;
  //
  //   /// Set a ping received callback if needed, called whenever a ping response(pong) is received
  //   /// from the broker.
  //   client.pongCallback = pong;
  //
  //   /// Set the appropriate websocket headers for your connection/broker.
  //   /// Mosquito uses the single default header, other brokers may be fine with the
  //   /// default headers.
  //   client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;
  //
  //   try {
  //     await client.connect(widget.user,widget.password);
  //   } on Exception catch (e) {
  //     print('EXAMPLE::client exception - $e');
  //     client.disconnect();
  //     return -1;
  //   }    final pubtopic = "d/${device}/s/${widget.user}/CP/1/$protoco";
  //   final builder = MqttClientPayloadBuilder();
  //   builder.addString(jsonEncode(
  //       [
  //         {
  //           "d":!_check ? 0 : 1
  //         }
  //         ]
  //   ));
  //   client.publishMessage(pubtopic, MqttQos.atLeastOnce, builder.payload!);
  //   print("Complete: $pubtopic");
  // }

  Widget build(BuildContext context) {
    _MQTT("${name_device}");
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomAppbar(),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white60,
        child: DrawerPage(),
      ),
      body: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 5)).asyncMap((event) => _Read()),
          builder: (context, snapshot) => charge == null ? Center(
            child: CircularProgressIndicator(
              color: Colors.greenAccent,
            ),
          ) : Column(
            children: [
          //     Container(
          //       child: Center(
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //             border: Border.all(
          //               color: Colors.black12,
          //               width: 4*heightR,
          //             ),
          //             boxShadow: [ //BoxShadow
          //               BoxShadow(
          //                 color: Colors.white,
          //                 offset: const Offset(0.0, 0.0),
          //                 blurRadius: 0.0,
          //                 spreadRadius: 0.0,
          //               ), //BoxShadow
          //             ],
          // ),
          //           child: TextButton(
          //             onPressed: (){
          //               setState(() {
          //                 _SoSanh();
          //               });
          //               AwesomeDialog(
          //                 context: context,
          //                 animType: AnimType.leftSlide,
          //                 headerAnimationLoop: false,
          //                 dialogType: DialogType.success,
          //                 showCloseIcon: true,
          //                 title: 'Update Complete',
          //                 btnOkOnPress: () {
          //                 },
          //                 btnOkIcon: Icons.check_circle,
          //               ).show();
          //             },
          //             child: Text("Update",style: TextStyle(
          //               fontSize: 26*heightR
          //             ),),
          //           ),
          //         ),
          //       ),
          //     ),
              Container(
                height: 100*heightR,
                child: check_1 ? Center(
                    child: SwitchListTile(
                        title: Row(
                          children: [
                            SizedBox(
                              width: 15*heightR,
                            ),
                            Icon(Icons.battery_charging_full),
                            SizedBox(
                              width: 35*heightR,
                            ),
                            Text('Charge'),
                          ],
                        ),
                        activeColor: Colors.teal,
                        activeTrackColor: Colors.green,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.blueGrey,
                        value: isOn_charge_mqtt,
                        onChanged: (bool value) {
                          setState(() {
                            isOn_charge_mqtt = value;
                            // _Publish(widget.namedevice.toString(),"charging_mos_switch",isOn_charge_mqtt);
                            postDataControl(id, "charging_mos_switch", isOn_charge_mqtt);
                            save(!isOn_charge_mqtt ? "0" : "1", "charging_mos_switch");
                          });
                        }
                    )
                ):Center(
                    child: SwitchListTile(
                        title: Row(
                          children: [
                            SizedBox(
                              width: 15*heightR,
                            ),
                            Icon(Icons.battery_charging_full),
                            SizedBox(
                              width: 35*heightR,
                            ),
                            Text('Charge'),
                          ],
                        ),
                        activeColor: Colors.teal,
                        activeTrackColor: Colors.green,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.blueGrey,
                        value: isOn_charge,
                        onChanged: (bool value) {
                          setState(() {
                            isOn_charge = value;
                            // _Publish(widget.namedevice.toString(),"charging_mos_switch",isOn_charge);
                            postDataControl(id, "charging_mos_switch", isOn_charge);
                            save(!isOn_charge ? "0" : "1", "charging_mos_switch");
                          });
                        }
                    )
                ),
              ),
              Container(
                height: 100*heightR,
                child: check_2 ? Center(
                    child: SwitchListTile(
                        title: Row(
                          children: [
                            SizedBox(
                                width: 15*heightR
                            ),
                            Icon(Icons.battery_saver),
                            SizedBox(
                                width: 35*heightR
                            ),
                            Text('Discharge'),
                          ],
                        ),
                        activeColor: Colors.teal,
                        activeTrackColor: Colors.green,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.blueGrey,
                        value: isOn_discharge_mqtt,
                        onChanged: (bool value) {
                          setState(() {
                            isOn_discharge_mqtt = value;
                            // _Publish(widget.namedevice.toString(),"discharge_mos_switch",isOn_discharge_mqtt);
                            postDataControl(id, "discharge_mos_switch", isOn_discharge_mqtt);
                            save(!isOn_discharge_mqtt ? "0" : "1", "discharge_mos_switch");
                          });
                        }
                    )
                ) : Center(
                    child: SwitchListTile(
                        title: Row(
                          children: [
                            SizedBox(
                                width: 15*heightR
                            ),
                            Icon(Icons.battery_saver),
                            SizedBox(
                                width: 35*heightR
                            ),
                            Text('Discharge'),
                          ],
                        ),
                        activeColor: Colors.teal,
                        activeTrackColor: Colors.green,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.blueGrey,
                        value: isOn_discharge,
                        onChanged: (bool value) {
                          setState(() {
                            isOn_discharge = value;
                            // _Publish(widget.namedevice.toString(),"discharge_mos_switch",isOn_discharge);
                            postDataControl(id, "discharge_mos_switch", isOn_discharge);
                            save(!isOn_discharge ? "0" : "1", "discharge_mos_switch");
                          });
                        }
                    )
                ),
              ),
              Container(
                height: 100*heightR,
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children: <Widget>[
                    ListTile(title: Text("Modify PWD"), leading: Icon(Icons.lock),onTap: (){},),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

postDataControl(final id,final propertyCode,bool _check) async{

  try{
    var response_control = await http.post(
        Uri.parse(
            "http://smarthome.test.makipos.net:3028/users-control-devices"),
        headers: {
          "Content-type": "application/json",
          "Authorization": token
        },
        body: jsonEncode(
            {
              "deviceId": id,
              "propertyCode": propertyCode,
              "localId": "1",
              "data": !_check ? 0 : 1,
              "waitResponse": false,
              "timeout": 1000
            }
        )
    );

  } catch(e){
    print(e);
  }
}

}
// void onConnected() {
//   print('Connected');
// }
//
// // unconnected
// void onDisconnected() {
//   print('Disconnected');
// }
//
// // subscribe to topic succeeded
// void onSubscribed(String topic) {
//   print('Subscribed topic: $topic');
// }
//
//
// // unsubscribe succeeded
// void onUnsubscribed(String topic) {
//   print('Unsubscribed topic: $topic');
// }
//
// // PING response received
// void pong() {
//   print('Ping response client callback invoked');
// }




