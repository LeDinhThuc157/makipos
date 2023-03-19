
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import '../theme/colors.dart';
import '../widgets/custom_appbar.dart';

class  ControlPage extends StatefulWidget {
  ControlPage({Key? key,
  this.trailing,
  required this.namedevice,
    required this.token,
    required this.pc ,
  this.isOn, this.id1, required this.user, required this.password
  }
): super(key: key);

  final String? id1;
  final Widget? trailing;
  final String? namedevice;
  var isOn;
   String token;
   String pc;
   final String user;
   final String password;
  @override
  State<ControlPage> createState() => _ControlPageState();

}

class _ControlPageState extends State<ControlPage> {
  var id;
  var isOn_charge ;
  var isOn_discharge ;
  var charge;
  var discharge;
  // var checkct = false;
  var data_1;
  var isOn_charge_mqtt ;
  var isOn_discharge_mqtt ;
  var check_1 = false,check_2 = false;

  @override
  GetDataControl(final propertyCode) async {


    try {
      String? id1 = widget.id1;
      id = id1;
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices/$id"),
        headers: {
          "Authorization": widget.token.toString()
        },
      );

      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);

      // if(userMap["data"] == null || userMap["data"].toString() == '[]' || responseGet_Listdevice.statusCode != 200){
      //   checkct = false;
      // }else{
      //   checkct = true;
      // }

      var _switch = userMap["propertiesValue"]["$propertyCode"].toString();
      if(propertyCode == "charging_mos_switch"){
        if(_switch == "1"){
          isOn_charge = true;
          charge = "1";
          isOn_charge_mqtt = true;
          // print("On CG $propertyCode:$isOn_charge");
        }
        if(_switch == "0"){
          isOn_charge = false;
          charge = "0";
          isOn_charge_mqtt = false;
          // print("Off CG:$isOn_charge");
        }
      }
      if(propertyCode == "discharge_mos_switch"){
        if(_switch == "1"){
          isOn_discharge = true;
          discharge = "1";
          isOn_discharge_mqtt = true;
          // print("On DCG $propertyCode:$isOn_discharge");
        }
        if(_switch == "0"){
          isOn_discharge = false;
          discharge = "0";
          isOn_discharge_mqtt = false;
          // print("Off DCG:$isOn_discharge");
        }
      }
    } catch (e) {
      print(e);
    }

  }

  _FetchAPI(){
    GetDataControl("charging_mos_switch");
    GetDataControl("discharge_mos_switch");
  }

  _MQTT(String device) async {

    final client = MqttBrowserClient('ws://smarthome.test.makipos.net:8083/mqtt', '${widget.user}');
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
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;



    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;
    // client.onSubscribeFail = onSubscribeFail;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Set the appropriate websocket headers for your connection/broker.
    /// Mosquito uses the single default header, other brokers may be fine with the
    /// default headers.
    client.websocketProtocols = MqttClientConstants.protocolsSingleDefault;

    try {
      await client.connect(widget.user,widget.password);
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
      //
      // print('Received message:$payload from topic: ${c[0].topic}>');
      // print("Data: ${data_1[0]['d']}");
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
    _FetchAPI();
    _MQTT("${widget.namedevice}");
    double  heightR,widthR;
    heightR = MediaQuery.of(context).size.height / 1080; //v26
    widthR = MediaQuery.of(context).size.width / 2400;
    var curR = widthR;

    return Scaffold(
      appBar: CustomAppbar(widget.token.toString(),widget.user,widget.password),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: Stream.periodic(Duration(microseconds: 100)),
          builder: (context, snapshot) =>Column(
            children: [
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
              // Container(
              //   height: 100*heightR,
              //   child: check_1 ? Text("Tra ve charge: ${data_1[0]['d']}",
              //     style: TextStyle(
              //         fontSize: 30*heightR,
              //         color: Colors.black
              //     ),
              //   ) : Text("data",style: TextStyle(
              //       fontSize: 30*heightR,
              //       color: Colors.black
              //   ),),
              // ),
              // Container(
              //   height: 100*heightR,
              //   child: check_2 ? Text("Tra ve Discharge: ${data_1[0]['d']}",
              //     style: TextStyle(
              //         fontSize: 30*heightR,
              //         color: Colors.black
              //     ),
              //   ) : Text("data",style: TextStyle(
              //       fontSize: 30*heightR,
              //       color: Colors.black
              //   ),),
              // ),


            ],
          )
      ),

      // StreamBuilder(
      //   stream: Stream.periodic(Duration(seconds: 3)).asyncMap((event) => _FetchAPI()),
      //   builder: (context, snapshot) => !checkct ? Column(
      //     children: [
      //       Container(
      //         height: 100*heightR,
      //         child: Center(
      //             child: SwitchListTile(
      //                 title: Row(
      //                   children: [
      //                     SizedBox(
      //                       width: 15*heightR,
      //                     ),
      //                     Icon(Icons.battery_charging_full),
      //                     SizedBox(
      //                       width: 35*heightR,
      //                     ),
      //                     Text('Charge'),
      //                   ],
      //                 ),
      //                 activeColor: Colors.teal,
      //                 activeTrackColor: Colors.green,
      //                 inactiveThumbColor: Colors.black,
      //                 inactiveTrackColor: Colors.blueGrey,
      //                 value: isOn_charge,
      //                 onChanged: (bool value) {
      //                   setState(() {
      //                     isOn_charge = value;
      //                     postDataControl(id, "charging_mos_switch", isOn_charge);
      //                   });
      //                 }
      //             )
      //         ),
      //       ),
      //       Container(
      //         height: 100*heightR,
      //         child: Center(
      //             child: SwitchListTile(
      //                 title: Row(
      //                   children: [
      //                     SizedBox(
      //                         width: 15*heightR
      //                     ),
      //                     Icon(Icons.battery_saver),
      //                     SizedBox(
      //                         width: 35*heightR
      //                     ),
      //                     Text('Discharge'),
      //                   ],
      //                 ),
      //                 activeColor: Colors.teal,
      //                 activeTrackColor: Colors.green,
      //                 inactiveThumbColor: Colors.black,
      //                 inactiveTrackColor: Colors.blueGrey,
      //                 value: isOn_discharge,
      //                 onChanged: (bool value) {
      //                   setState(() {
      //                     isOn_discharge = value;
      //                     postDataControl(id, "discharge_mos_switch", isOn_discharge);
      //                   });
      //                 }
      //             )
      //         ),
      //       ),
      //       Container(
      //         height: 100*heightR,
      //         child: ListView(
      //           padding: EdgeInsets.all(8),
      //           children: <Widget>[
      //             ListTile(title: Text("Modify PWD"), leading: Icon(Icons.lock),onTap: (){},),
      //           ],
      //         ),
      //       ),
      //
      //     ],
      //   ): SizedBox(),
      // )
    );
  }

postDataControl(final id,final propertyCode,bool _check) async{

  try{
    var response_control = await http.post(
        Uri.parse(
            "http://smarthome.test.makipos.net:3028/users-control-devices"),
        headers: {
          "Content-type": "application/json",
          "Authorization": widget.token.toString()
        },
        body: jsonEncode(
            {
              "deviceId": id,
              "propertyCode": propertyCode,
              "localId": "1",
              "data": !_check ? 0 : 1,
              "waitResponse": false,
              "timeout": 100
            }
        )
    );

    Map<String, dynamic> userMap = jsonDecode(response_control.body);
    // print("StatusControl $propertyCode : ${response_control.statusCode}"
    //     "Value:${response_control.body}");
    // if(_check) print("Bật ${!_check ? 0 : 1}");
    // else {
    //   print("Tắt ${!_check ? 0 : 1}");
    // }
  } catch(e){
    print(e);
  }
}

}
void onConnected() {
  print('Connected');
}

// unconnected
void onDisconnected() {
  print('Disconnected');
}

// subscribe to topic succeeded
void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

// subscribe to topic failed
// void onSubscribeFail(String topic) {
//   print('Failed to subscribe $topic');
// }

// unsubscribe succeeded
void onUnsubscribed(String topic) {
  print('Unsubscribed topic: $topic');
}

// PING response received
void pong() {
  print('Ping response client callback invoked');
}
/*
ListView.builder(
                  itemCount: appliances.length,
                  itemBuilder: (context, index) {
                    GetDataControl(appliances[index]._pc);
                    appliances[index].isOn = check;
                    print("Check1: ${appliances[index].isOn}");
                    return SwitchListTile(
                      title: Text('${appliances[index].name}'),
                      value: appliances[index].isOn,
                      onChanged: (bool value) {
                        setState(() {
                          print("Value: ${value}");
                          appliances[index].isOn = value;
                          print("Click: ${appliances[index].isOn}");
                          postDataControl(id , appliances[index]._pc, appliances[index].isOn);
                        });

                      },
                      secondary: appliances[index].trailing,
                    );

                  },
                )
*/



