
import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class  AlarmPage extends StatefulWidget {
  AlarmPage({Key ? key,}

      ):super(key: key);
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage>{
  final Storage _localStorage = window.localStorage;
  var user;
  var password;
  var name_device;
  var data_1;
  Future<String?> _user() async => user = _localStorage['username'];
  Future<String?> _pass() async => password = _localStorage['password'];
  Future<String?> _namedevice() async => name_device = _localStorage['Name_device'];
  @override
  void initState(){
    super.initState();
    _namedevice();
    _MQTT("${name_device}");
  }
  _MQTT(String device) async {
    _user(); _pass();
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
      print("Warning: ${data_1['d']}\n $data_1");

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Alarm"),
      ),
      body: Container(
        child: Text("${data_1['d']}"),
      ),
    );
  }

}